<template>
  <div class="card">
        <div class="card_sta">
<!--
            <div class="card_block">
                <div class="card_item">
                    <span class="card_title">平台总利润</span>
                    <span style="margin-bottom:9px">{{statisticsData.total_ben_profit}}PHP/{{statisticsData.total_usdt_profit}}U</span>
                    <span>今日利润&nbsp;&nbsp;{{statisticsData.today_ben_profit}}PHP/{{ statisticsData.today_usdt_profit }}U</span>
                    <span>昨日利润&nbsp;&nbsp;{{statisticsData.yesterday_ben_profit}}PHP/{{ statisticsData.yesterday_usdt_profit }}</span>
                </div>
            </div> -->
            <div class="card_block">
                <div class="card_item">
                    <span class="card_title">总注册量</span>
                    <span style="margin-bottom:9px">{{statisticsData.total_register}}</span>
                    <span>今日注册量&nbsp;&nbsp;{{statisticsData.today_register}}</span>
                    <!-- <span>昨日注册量&nbsp;&nbsp;{{statisticsData.yesterday_register}}</span> -->
                    <!-- <span>当前在线人数&nbsp;&nbsp;{{statisticsData.dangqianzaixianrenshu}}</span> -->
                </div>
            </div>
            <div class="card_block">
                <div class="card_item">
                    <span class="card_title">总充值笔数</span>
                    <span style="margin-bottom:9px">{{statisticsData.total_recharger_num}}</span>
                    <span>今日值笔数&nbsp;&nbsp;{{statisticsData.today_recharger_num}}</span>
                    <!-- <span>昨日值笔数&nbsp;&nbsp;{{statisticsData.yesterday_recharger_num}}</span> -->
                </div>
            </div>
            <div class="card_block">
                <div class="card_item">
                    <span class="card_title">总充值金额</span>
                    <span style="margin-bottom:9px">{{statisticsData.total_recharger_ben_money}}</span>
                    <span>今日充值金额&nbsp;&nbsp;{{statisticsData.today_recharger_ben_money}}</span>
                    <!-- <span>昨日充值金额&nbsp;&nbsp;{{statisticsData.yesterday_recharger_ben_money}}</span> -->
                </div>
            </div>
            <div class="card_block">
                <div class="card_item">
                    <span class="card_title">总提现笔数</span>
                    <span style="margin-bottom:9px">{{statisticsData.total_cash_num}}</span>
                    <span>今日提现笔数&nbsp;&nbsp;{{statisticsData.today_cash_num}}</span>
                    <!-- <span>昨日提现笔数&nbsp;&nbsp;{{statisticsData.yesterday_cash_num}}</span> -->
                </div>
            </div>
            <div class="card_block">
                <div class="card_item">
                    <span class="card_title">总提现金额</span>
                    <span style="margin-bottom:9px">{{statisticsData.total_cash_ben_money}}</span>
                    <span>今日提现金额&nbsp;&nbsp;{{statisticsData.today_cash_ben_money}}</span>
                    <!-- <span>昨日提现金额&nbsp;&nbsp;{{statisticsData.yesterday_ben_money}}PHP/{{statisticsData.yesterday_usdt_money}}U</span> -->
                </div>
            </div>
            <div class="card_block">
                <div class="card_item">
                    <span class="card_title">充值人数</span>
                    <span style="margin-bottom:9px">{{statisticsData.recharger_man}}</span>
                    <!-- <span>充值率&nbsp;&nbsp;{{statisticsData.recharger_rate}}%</span>
                    <span>复充人数&nbsp;&nbsp;{{statisticsData.recharging_man}}</span>
                    <span>复充率&nbsp;&nbsp;{{statisticsData.recharging_rate}}%</span> -->
                </div>
            </div>
            <div class="card_block">
                <div class="card_item">
                    <span class="card_title">总购买产品数</span>
                    <span style="margin-bottom:9px">{{statisticsData.total_product_num}}</span>
                    <span>今日购买产品数&nbsp;&nbsp;{{statisticsData.today_product_num}}</span>
                    <!-- <span>昨日购买产品数&nbsp;&nbsp;{{statisticsData.yesterday_product_num}}</span> -->
                </div>
            </div>
            <div class="card_block">
                <div class="card_item">
                    <span class="card_title">总购产品买金额</span>
                    <span style="margin-bottom:9px">{{statisticsData.total_product_ben_money }}</span>
                    <span>今日购买金额&nbsp;&nbsp;{{statisticsData.today_product_ben_money}}</span>
                    <!-- <span>昨日购买金额&nbsp;&nbsp;{{statisticsData.yesterday_product_ben_money }}PHP/{{ statisticsData.yesterday_product_usdt_money }}U</span> -->
                </div>
            </div>
        </div>
    <!-- <ul>
      <li v-for="(item, index) in dataList" :key="index" :style="dataListStyle">
        <svg class="svg-icon " aria-hidden="true"><use :xlink:href="item.icon"></use></svg>
        <span class="des">{{item.des}}</span>
        <count-to class="number" :startVal='item.startVal' :endVal='item.endVal' :duration='1500' separator='' />
      </li>
    </ul> -->
    <!--
      <br>
      <ul>
         <li v-for="(item, index) in dataListss" :key="index" :style="dataListStyle">
           <svg class="svg-icon " aria-hidden="true"><use :xlink:href="item.icon"></use></svg>
           <span class="des">{{item.des}}</span>
           <count-to class="number" :startVal='item.startVal' :endVal='item.endVal' :duration='1500' separator='' />
         </li>
       </ul> -->

  </div>
</template>

<script>
  import countTo from 'vue-count-to'
  import {
getRegisterTodayApi,
getRegisterTotalApi,
getRechargeTodayApi,
getRechargeTotalApi,
getWithdrawalTodayApi,
getWithdrawalTotalApi,
getOrderTodayPayApi,
getOrderTotalPayApi,
getOrderTotalMoneyApi,
getOrderTodayMoneyApi,
getStatisticsApi,
getRegisterApi,
getRechargeApi,
getWithdrawalApi,
getOrderApi,
    } from '@/api/CountApi'
  export default {
    name: "ConsoleCard",
    components: {
      countTo
    },
    data() {
      return {
        startVal: 0,
        dataList: [
          {
            des: '总注册人数',
            icon: '#iconyonghu1',
            startVal: 0,
            duration: 1000,
            endVal: 0,
            width: 24,
            height: 26,
          },
          {
            des: '今日注册人数',
            icon: '#iconyonghu1',
            startVal: 0,
            duration: 1000,
            endVal: 0,
            width: 24,
            height: 25
          },
          {
            des: '总充值金额',
            icon: '#iconsidebar',
            startVal: 0,
            duration: 1000,
            endVal: 0,
            width: 27,
            height: 25
          },
          {
            des: '今日充值金额',
            icon: '#iconsidebar',
            startVal: 0,
            duration: 1000,
            endVal: 0,
            width: 24,
            height: 25,
          },
          {
            des: '总提现金额',
            icon: '#iconquyufangwenqushi',
            startVal: 0,
            duration: 1000,
            endVal: 0,
            width: 24,
            height: 24
          },
          {
            des: '今日提现金额',
            icon: '#iconquyufangwenqushi',
            startVal: 0,
            duration: 1000,
            endVal: 0,
            width: 27,
            height: 25
          },
        ],
        statisticsData: {},
        dataListss:[
          {
            des: '总订单数',
            icon: '#iconshalou',
            startVal: 0,
            duration: 1000,
            endVal: 0,
            width: 27,
            height: 25
          },
          {
            des: '今日订单数',
            icon: '#iconshalou',
            startVal: 0,
            duration: 1000,
            endVal: 0,
            width: 27,
            height: 25
          },
          {
            des: '总订单金额',
            icon: '#iconchuli',
            startVal: 0,
            duration: 1000,
            endVal: 0,
            width: 27,
            height: 25
          },
          {
            des: '今日订单金额',
            icon: '#iconchuli',
            startVal: 0,
            duration: 1000,
            endVal: 0,
            width: 27,
            height: 25
          },

        ],
        endVal: 2020,
        duration: 1000,
        dataListStyle: {},
      };
    },
    mounted() {
      this.computedItemWidth()
      this.getUserList()
    },
    methods: {
      getUserList(){//endVal
        getStatisticsApi().then(res => {
            this.statisticsData = res.data
        })
      //注册
        // getRegisterApi().then(res => {
        //   this.dataList[0].endVal=res.data.total
        //   this.dataList[1].endVal=res.data.today
        // }),
        // //充值
        // getRechargeApi().then(res => {
        //   this.dataList[2].endVal=res.data.total
        //   this.dataList[3].endVal=res.data.today
        // }),
        // //提现
        // getWithdrawalApi().then(res => {
        //   this.dataList[4].endVal=res.data.total
        //   this.dataList[5].endVal=res.data.today
        // }),
        // getOrderApi().then(res => {
        //   this.dataListss[0].endVal=res.data.total
        //   this.dataListss[1].endVal=res.data.today
        // }),
        // getOrderTotalMoneyApi().then(res => {
        //   this.dataListss[2].endVal=res.data.total
        // }),
        // getOrderTodayMoneyApi().then(res => {
        //   this.dataListss[3].endVal=res.data.total
        // })
        },
      computedItemWidth() {
        let count = this.dataList;
        let width = 100 / count;

        this.dataListStyle = {
          width: `calc(${width}% - 20px)`
        }
      }
    }
  };
</script>

<style lang="scss" scoped>
  .card {
    overflow: hidden;
    background: transparent !important;
    .card_sta{
        display: flex;
        flex-wrap: wrap;
    }
    .card_block{
        display: flex;
        min-width: calc(16.666% - 15px);
        height: 125px;
        text-align: center;
        margin: 0 0 0 15px;
        box-sizing: border-box;
        background: #fff;
        display: flex;
        -webkit-box-pack: justify;
        -ms-flex-pack: justify;
        justify-content: space-around;
        position: relative;
        border-radius: 3px;
        display: flex;
        justify-content: center;
        align-items: center;
        margin-bottom: 10px;
        box-shadow: 0 0px 7px rgba(28,76,186,.08);
        transition: box-shadow .3s;

        &:hover {
          box-shadow: 0 5px 20px rgba(28,76,186,.12);
        }
    }
    .svg-icon {
        width: 40px;
    }
    .card_item span{
        font-weight: 500;
        font-size: 14px;
    }
    .card_item{
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
    }
    .card_title{
        font-size: 18px !important;
        font-weight: bold;
    }

    ul {
      width: calc(100% + 15px);
      margin-left: -15px;
      display: flex;
      flex-wrap: wrap;
      box-sizing: border-box;
      background: transparent !important;

      li {
        width: calc(16.666% - 15px);
        height: 125px;
        line-height: 125px;
        text-align: center;
        margin: 0 0 0 15px;
        box-sizing: border-box;
        background: #fff;
        display: flex;
        justify-content: space-between;
        padding: 0 40px;
        position: relative;
        border-radius: 3px;
        box-shadow: 0 0px 7px rgba(28,76,186,.08);
        transition: box-shadow .3s;

        &:hover {
          box-shadow: 0 5px 20px rgba(28,76,186,.12);
        }

        .svg-icon {
          width: 3em;
          height: 3em;
          vertical-align: -0.15em;
          fill: currentColor;
          overflow: hidden;
          position: absolute;
          top: 50%;
          transform: translate(0, -50%);
          -moz-transform: translate(0, -50%);
          -webkit-transform: translate(0, -50%);
          bottom: 0;
          left: 10%;
        }

        .number {
          color: #515a6e;
          font-size: 26px;
          line-height: 26px;
          margin: 0;
          position: absolute;
          bottom: 50%;
          right: 10%;
        }

        .des {
          color: #999999;
          font-size: 13px;
          line-height: 14px;
          height: 14px;

          position: absolute;
          bottom: 30%;
          right: 10%;
          user-select: none;
          -moz-user-select: none;
          -webkit-user-select: none;
        }

      }
    }
  }

  @media only screen and (max-width: #{$device-notebook})  {
    .card {
      padding-top: 0 !important;

      ul {
        li {
          height: 100px;

          .des {
            font-size: 12px;
          }
        }
      }

      .iconfont {
        left: 15px !important;
      }

      .number, .des {
        right: 15px !important;
      }
    }
  }

  @media only screen and (max-width: #{$device-ipad}) {
    .card {

      ul {
        width: calc(100% + 15px);
        margin-left: -15px;
        display: flex;
        flex-wrap: wrap;
        box-sizing: border-box;

        li {
          width: calc(33.333% - 15px);
          height: 120px;
          line-height: 120px;
          margin-bottom: 15px;
        }
      }
    }
  }

  @media only screen and (max-width: #{$device-phone}) {
    .card {

      ul {
        width: calc(100% + 15px);
        margin-left: -15px;
        display: flex;
        flex-wrap: wrap;
        box-sizing: border-box;

        li {
          width: 100%;
          height: 100px;
          line-height: 100px;
          margin-bottom: 10px;
        }
      }
    }
  }
</style>
