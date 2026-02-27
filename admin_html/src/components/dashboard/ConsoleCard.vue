<template>
  <div class="console-cards">
    <div class="stats-grid">

      <div class="stat-card card-blue">
        <div class="card-icon-wrap">
          <i class="el-icon-user-solid"></i>
        </div>
        <div class="card-body">
          <p class="card-label">总注册量</p>
          <p class="card-value">{{ statisticsData.total_register || 0 }}</p>
          <div class="card-footer">
            <span class="footer-tag">今日</span>
            <span class="footer-num">{{ statisticsData.today_register || 0 }}</span>
            <span class="footer-divider">|</span>
            <span class="footer-tag">昨日</span>
            <span class="footer-num">{{ statisticsData.yesterday_register || 0 }}</span>
          </div>
        </div>
        <div class="card-bg-icon"><i class="el-icon-user-solid"></i></div>
      </div>

      <div class="stat-card card-green">
        <div class="card-icon-wrap">
          <i class="el-icon-bank-card"></i>
        </div>
        <div class="card-body">
          <p class="card-label">总充值笔数</p>
          <p class="card-value">{{ statisticsData.total_recharger_num || 0 }}</p>
          <div class="card-footer">
            <span class="footer-tag">今日</span>
            <span class="footer-num">{{ statisticsData.today_recharger_num || 0 }}</span>
          </div>
        </div>
        <div class="card-bg-icon"><i class="el-icon-bank-card"></i></div>
      </div>

      <div class="stat-card card-teal">
        <div class="card-icon-wrap">
          <i class="el-icon-money"></i>
        </div>
        <div class="card-body">
          <p class="card-label">总充值金额</p>
          <p class="card-value">{{ statisticsData.total_recharger_ben_money || 0 }}</p>
          <div class="card-footer">
            <span class="footer-tag">今日</span>
            <span class="footer-num">{{ statisticsData.today_recharger_ben_money || 0 }}</span>
          </div>
        </div>
        <div class="card-bg-icon"><i class="el-icon-money"></i></div>
      </div>

      <div class="stat-card card-orange">
        <div class="card-icon-wrap">
          <i class="el-icon-s-finance"></i>
        </div>
        <div class="card-body">
          <p class="card-label">总提现笔数</p>
          <p class="card-value">{{ statisticsData.total_cash_num || 0 }}</p>
          <div class="card-footer">
            <span class="footer-tag">今日</span>
            <span class="footer-num">{{ statisticsData.today_cash_num || 0 }}</span>
          </div>
        </div>
        <div class="card-bg-icon"><i class="el-icon-s-finance"></i></div>
      </div>

      <div class="stat-card card-red">
        <div class="card-icon-wrap">
          <i class="el-icon-coin"></i>
        </div>
        <div class="card-body">
          <p class="card-label">总提现金额</p>
          <p class="card-value">{{ statisticsData.total_cash_ben_money || 0 }}</p>
          <div class="card-footer">
            <span class="footer-tag">今日</span>
            <span class="footer-num">{{ statisticsData.today_cash_ben_money || 0 }}</span>
          </div>
        </div>
        <div class="card-bg-icon"><i class="el-icon-coin"></i></div>
      </div>

      <div class="stat-card card-purple">
        <div class="card-icon-wrap">
          <i class="el-icon-s-custom"></i>
        </div>
        <div class="card-body">
          <p class="card-label">充值人数</p>
          <p class="card-value">{{ statisticsData.recharger_man || 0 }}</p>
          <div class="card-footer">
            <span class="footer-tag">累计</span>
            <span class="footer-num">充值用户</span>
          </div>
        </div>
        <div class="card-bg-icon"><i class="el-icon-s-custom"></i></div>
      </div>

      <div class="stat-card card-indigo">
        <div class="card-icon-wrap">
          <i class="el-icon-goods"></i>
        </div>
        <div class="card-body">
          <p class="card-label">总购买产品数</p>
          <p class="card-value">{{ statisticsData.total_product_num || 0 }}</p>
          <div class="card-footer">
            <span class="footer-tag">今日</span>
            <span class="footer-num">{{ statisticsData.today_product_num || 0 }}</span>
          </div>
        </div>
        <div class="card-bg-icon"><i class="el-icon-goods"></i></div>
      </div>

      <div class="stat-card card-pink">
        <div class="card-icon-wrap">
          <i class="el-icon-shopping-cart-full"></i>
        </div>
        <div class="card-body">
          <p class="card-label">总购买产品金额</p>
          <p class="card-value">{{ statisticsData.total_product_ben_money || 0 }}</p>
          <div class="card-footer">
            <span class="footer-tag">今日</span>
            <span class="footer-num">{{ statisticsData.today_product_ben_money || 0 }}</span>
          </div>
        </div>
        <div class="card-bg-icon"><i class="el-icon-shopping-cart-full"></i></div>
      </div>

      <div class="stat-card card-cyan">
        <div class="card-icon-wrap">
          <i class="el-icon-s-opportunity"></i>
        </div>
        <div class="card-body">
          <p class="card-label">当前在线人数</p>
          <p class="card-value">{{ statisticsData.dangqianzaixianrenshu || 0 }}</p>
          <div class="card-footer">
            <span class="footer-tag">实时</span>
            <span class="footer-num">2小时内活跃</span>
          </div>
        </div>
        <div class="card-bg-icon"><i class="el-icon-s-opportunity"></i></div>
      </div>

    </div>
  </div>
</template>

<script>
  import { getStatisticsApi } from '@/api/CountApi'
  export default {
    name: "ConsoleCard",
    data() {
      return {
        statisticsData: {},
      };
    },
    mounted() {
      this.getUserList()
    },
    methods: {
      getUserList() {
        getStatisticsApi().then(res => {
          this.statisticsData = res.data
        })
      }
    }
  };
</script>

<style lang="scss" scoped>
.console-cards {
  padding: 0;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 16px;
}

.stat-card {
  position: relative;
  border-radius: 12px;
  padding: 20px 20px 16px;
  display: flex;
  align-items: flex-start;
  gap: 14px;
  overflow: hidden;
  color: #fff;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.12);
  transition: transform 0.25s, box-shadow 0.25s;
  cursor: default;

  &:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.18);
  }
}

.card-icon-wrap {
  flex-shrink: 0;
  width: 48px;
  height: 48px;
  border-radius: 10px;
  background: rgba(255, 255, 255, 0.25);
  display: flex;
  align-items: center;
  justify-content: center;

  i {
    font-size: 24px;
    color: #fff;
  }
}

.card-body {
  flex: 1;
  min-width: 0;
  position: relative;
  z-index: 1;
}

.card-label {
  margin: 0 0 8px;
  font-size: 15px;
  opacity: 0.92;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.card-value {
  margin: 0 0 12px;
  font-size: 32px;
  font-weight: 700;
  line-height: 1;
  letter-spacing: -0.5px;
}

.card-footer {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 14px;
  opacity: 0.9;
}

.footer-tag {
  background: rgba(255, 255, 255, 0.25);
  border-radius: 4px;
  padding: 2px 8px;
  font-size: 13px;
}

.footer-num {
  font-weight: 500;
}

.footer-divider {
  opacity: 0.4;
  margin: 0 2px;
}

.card-bg-icon {
  position: absolute;
  right: -10px;
  bottom: -10px;
  opacity: 0.1;
  pointer-events: none;

  i {
    font-size: 90px;
    color: #fff;
  }
}

/* Card color themes */
.card-blue   { background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); }
.card-green  { background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%); }
.card-teal   { background: linear-gradient(135deg, #0ba360 0%, #3cba92 100%); }
.card-orange { background: linear-gradient(135deg, #f7971e 0%, #ffd200 100%); }
.card-red    { background: linear-gradient(135deg, #f5515f 0%, #9f041b 100%); }
.card-purple { background: linear-gradient(135deg, #a18cd1 0%, #fbc2eb 100%); }
.card-indigo { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
.card-pink   { background: linear-gradient(135deg, #f953c6 0%, #b91d73 100%); }
.card-cyan   { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); }

@media only screen and (max-width: 1200px) {
  .stats-grid {
    grid-template-columns: repeat(3, 1fr);
  }
}

@media only screen and (max-width: 900px) {
  .stats-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media only screen and (max-width: 560px) {
  .stats-grid {
    grid-template-columns: 1fr;
  }
}
</style>
