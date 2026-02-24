<?php

// 连接Redis
$redis = new Redis();
$redis->connect('127.0.0.1', 6379);

// 原始队列名称
$queueName = 'order_queue';
// 死信队列名称
$deadLetterQueueName = 'dead_letter_queue';

// 模拟订单信息
$order = [
    'order_id' => '123456',
    'amount' => 100.00,
    'status' => 'unpaid'
];

// 将订单信息发送到原始队列
$redis->lPush($queueName, json_encode($order));

// 消费者处理消息
function processMessage($message)
{
    // 模拟支付处理
    $order = json_decode($message, true);
    $orderId = $order['order_id'];
    $amount = $order['amount'];
    $status = $order['status'];

    // 模拟支付失败或超时
    $success = false;
    if ($status === 'unpaid') {
        $success = false; // 支付失败
    } else {
        $success = true; // 支付成功
    }

    if ($success) {
        // 支付成功，删除消息
        $deleted = $redis->lRem($deadLetterQueueName, $message, 0);
        if ($deleted > 0) {
            echo "订单{$orderId}支付成功，消息已删除" . PHP_EOL;
        } else {
            echo "订单{$orderId}支付成功，但消息删除失败" . PHP_EOL;
        }
    } else {
        // 支付失败或超时，尝试删除消息两次
        $deleted = $redis->lRem($deadLetterQueueName, $message, 0);
        if ($deleted > 0) {
            echo "订单{$orderId}支付失败或超时，消息已删除" . PHP_EOL;
        } else {
            $deleted = $redis->lRem($deadLetterQueueName, $message, 0);
            if ($deleted > 0) {
                echo "订单{$orderId}支付失败或超时，消息已删除" . PHP_EOL;
            } else {
                // 删除失败，将消息重新放回原始队列
                $redis->lPush($queueName, $message);
                echo "订单{$orderId}支付失败或超时，消息已重新放回原始队列" . PHP_EOL;
            }
        }
    }
}

// 从死信队列中获取消息进行处理
while (true) {
    $message = $redis->rPop($deadLetterQueueName);
    if ($message) {
        processMessage($message);
    } else {
        // 死信队列为空，等待一段时间后继续尝试获取消息
        sleep(1);
    }
}
