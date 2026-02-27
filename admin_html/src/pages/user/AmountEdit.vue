<template>
  <div class='page-content'>
   <div slot="top" v-if="operate">
      <el-form label-width="90px">
        <el-row :gutter="20">
          <el-col :xs="24" :sm="12" :lg="3">
            <el-input placeholder="手机号" v-model="searchParameter.phone"></el-input>
          </el-col>
          <el-col :xs="24" :sm="12" :lg="3">
            <el-input placeholder="ID查询" v-model="searchParameter.id"></el-input>
          </el-col>
          <el-col :xs="24" :sm="12" :lg="3">
            <el-input placeholder="用户名" v-model="searchParameter.user_name"></el-input>
          </el-col>
          <el-col :xs="24" :sm="12" :lg="3">
            <el-input placeholder="团队号" v-model="searchParameter.user_team"></el-input>
          </el-col>
         <!-- <el-col :xs="24" :sm="12" :lg="4">
                  <el-date-picker
                    v-model="searchParameter.start"
                    type="date"
                    placeholder="开始日期">
                  </el-date-picker>
          </el-col>
          <el-col :xs="24" :sm="12" :lg="4" style="margin-left: 30px;">
                  <el-date-picker
                    v-model="searchParameter.end"
                    type="date"
                    placeholder="结束日期">
                  </el-date-picker>
          </el-col> -->
        </el-row>
        <el-row :xs="24" :sm="12" :lg="6" style="margin-top: 10px;">
          <el-button @click="search">搜索</el-button>
        </el-row>
      </el-form>
    </div>

    <el-table height="80vh" style="margin-top: 15px;" border v-if="operate" :data="roleList" :showPage="false">
      <el-table-column label="ID" width="65" prop="id" />
      <el-table-column label="用户电话" width="95" prop="phone" />
      <el-table-column label="用户名称" width="80" prop="user_name" />
      <!-- <el-table-column label="用户昵称" width="120" prop="nickname" /> -->

      <el-table-column label="个人总收益" width="100" prop="money_balance">
        <template slot-scope="scope">
          <el-button type="primary" @click="showMoneyDialog(scope.row,90)" >{{scope.row.money_balance}}</el-button>
        </template>
      </el-table-column>
      <el-table-column label="可提现金额" width="100" prop="money_approve">
        <template slot-scope="scope">
          <el-button type="primary" @click="showMoneyDialog(scope.row,18)">{{scope.row.money_approve}}</el-button>
        </template>
      </el-table-column>
      <el-table-column label="个人佣金(个人佣金+工资津贴)" width="110" prop="money_hire">
        <template slot-scope="scope">
          <el-button type="primary" @click="showMoneyDialog(scope.row,14)">{{scope.row.money_hire}}</el-button>
        </template>
      </el-table-column>
      <!-- <el-table-column label="团队津贴(个人佣金+工资)" width="110" prop="money_team">
        <template slot-scope="scope">
          <el-button type="primary" @click="showMoneyDialog(scope.row,15)">{{scope.row.money_team}}</el-button>
        </template>
      </el-table-column> -->

      <el-table-column label="积分" width="100" prop="money_integral">
        <template slot-scope="scope">
          <el-button type="primary" @click="showMoneyDialog(scope.row,12)">{{scope.row.money_integral}}</el-button>
        </template>
      </el-table-column>
      <el-table-column label="绿币" width="110" prop="money_green" >
        <template slot-scope="scope">
          <el-button type="primary" @click="showMoneyDialog(scope.row,13)">{{scope.row.money_green}}</el-button>
        </template>
      </el-table-column>

      <el-table-column label="碳票" width="110" prop="money_vote">
        <template slot-scope="scope">
          <el-button type="primary" @click="showMoneyDialog(scope.row,16)">{{scope.row.money_vote}}</el-button>
        </template>
      </el-table-column>
      <el-table-column label="碳汇" width="110" prop="money_converge">
        <template slot-scope="scope">
          <el-button type="primary" @click="showMoneyDialog(scope.row,17)">{{scope.row.money_converge}}</el-button>
        </template>
      </el-table-column>

      <el-table-column label="上级ID" width="80" prop="agent_id"/>
      <el-table-column label="所属团队号" width="80" prop="user_team"/>

      <!-- <el-table-column label="创建时间"  prop="create_time" /> -->
    </el-table>

    <div class='verification-box' v-else>
        <el-form ref="form" :model="moneyForm" label-width="70px">
          <el-form-item label="操作密码">
            <el-input v-model="operate_pwd" placeholder="请输入操作密码"></el-input>
          </el-form-item>
        </el-form>
        <span style="position:relative;left: 350px;top:-50px" slot="footer" class="dialog-footer">
          <el-button type="primary" @click="onSubmit">确 定</el-button>
        </span>
    </div>

    <el-dialog :title="dialogMoneyTitle" width="500px" :visible.sync="moneyDialogVisible">
      <el-form ref="form" :model="moneyForm" label-width="70px">
        <el-form-item label="变更类型">
          <el-select v-model="money_change_type" style="width:100%" placeholder="请选择">
            <el-option key="1" label="增加" value="1"></el-option>
            <el-option key="2" label="减少" value="2"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="变更金额">
          <el-input type="number" min="0" v-model="change_money" placeholder="请输入变更金额"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="moneyDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="onMoneySubmit">确 定</el-button>
      </span>
    </el-dialog>

    <template v-if="allpage>10">
      <el-pagination @current-change="handleCurrentChange" @size-change="handleSizeChange" :current-page="1" :page-sizes="[10, 20, 50, 100]" :page-size="pageSize" layout="sizes, total, prev, pager, next, jumper"
        :total="allpage">
      </el-pagination>
    </template>
  </div>
</template>

<script>

  import {getIsWithdrawalStatusApi,getUserWithdrawalStatusApi,getUserStatusApigetUserStatusApi,getIsStatusApi,getUserListApi,getMoneyOperateApi,getMoneyEditApi,getDailiData, getactionCon} from '@/api/userApi'
  import {getMoneyListApi} from '@/api/MoneylogApi'
  export default {
    data() {
      return {
        role: null,
        pickerOptions: {
                  disabledDate(time) {
                    return time.getTime() > Date.now();
                  },
                  shortcuts: [{
                    text: '今天',
                    onClick(picker) {
                      picker.$emit('pick', new Date());
                    }
                  }, {
                    text: '昨天',
                    onClick(picker) {
                      const date = new Date();
                      date.setTime(date.getTime() - 3600 * 1000 * 24);
                      picker.$emit('pick', date);
                    }
                  }, {
                    text: '一周前',
                    onClick(picker) {
                      const date = new Date();
                      date.setTime(date.getTime() - 3600 * 1000 * 24 * 7);
                      picker.$emit('pick', date);
                    }
                  }]
                },
                value1: '',
                value2: '',
        allpage: 1, //总页数
        showItem: 5, //分页显示得中间按钮个数
        current: 1, //当前页
        pageSize: 10,
        dvEdit: false,
        operate: false,//是否验证
        dialogTitle: '',
        infotitle:'',
        operate_pwd:'',//操作密码
        form: {
          user_name: '',
          desc: '',
        },
        searchParameter: {
          user_name: undefined,
          market_uid: undefined,
          phone: undefined,
          data_time: undefined,
          page:1
        },
        props: {
          label: 'name',
          children: 'zones'
        },
        count: 1,
        roleList: [],
        rechargeList:[],
        currentRecharge:1,
        allpageRecharge: 1, //总页数
        uid:'',
        status:101,
        money_status:90,
        moneyDialogVisible:false,
        dialogMoneyTitle:'编辑可用余额',
        moneyForm:{},
        money_change_type:'',
        change_money:'',
        moneyType: 1,
        dataClassList: [],
        dailiData: [],
        actionConData: [],
        addBtnFlag: false,
        updateBtnFlag: false,
        deleteBtnFlag: false,
        tableBtnFlag: false
      };
    },
    mounted() {
      this.getDailiDataFun()
      // 代理商显示控制
      this.role = JSON.parse(localStorage.getItem('sys')).user.info.role
      this.getactionConFun()
    },
    async activated() {
      if (this.$route.query.phone) {
        this.searchParameter.phone = this.$route.query.phone
        await this.search()
      }
    },
    methods: {
      handleCancle(){
        if(!this.operate){
            this.$message({
              message:'请输入操作密码',
              type: 'error'
             });
        }
      },
      onSubmit:function(){
          getMoneyOperateApi({
            operate_pwd:this.operate_pwd,
          }).then(res => {
            this.operate_pwd = '';
            if(res.code === 1){
              this.operate = true;
              this.$message({
                message:'操作密码验证成功',
                type: 'success'
               });
               this.handleCurrentChange(this.current);
            }else{
              this.operate = false;
            }
          })
          .catch(()=>{
            this.$message({
              message:'操作密码验证错误',
              type: 'error'
             });
          })
      },
      // 获取action/con权限数据
      getactionConFun() {
        getactionCon().then(res => {
          if (res.code === 1) {
            this.actionConData = res.data
            for (let item of this.actionConData) {
              if (item.path === "/user/edit") this.updateBtnFlag = true
              if (item.path === "/user/add") this.addBtnFlag = true
              if (item.path === "/user/del") this.deleteBtnFlag = true
              if (item.path === "/money/edit") this.tableBtnFlag = true
            }
          }
        })
      },
      // 获取代理商数据
      getDailiDataFun() {
        getDailiData().then(res => {
          this.dailiData = res.data
        })
      },

      showMoneyDialog:function(row,type){
        this.moneyForm = row;
        this.money_change_type = '';
        this.change_money = '';
        this.money_status = type;
        if(type == 90){
          this.dialogMoneyTitle = '编辑可用余额';
        }else if(type == 11){
          this.dialogMoneyTitle = '编辑购买产品余额';
        }else if(type == 12){
          this.dialogMoneyTitle = '编辑积分';
        }else if(type == 13){
          this.dialogMoneyTitle = '编辑绿币';
        }else if(type == 14){
          this.dialogMoneyTitle = '编辑个人佣金';
        }else if(type == 15){
          this.dialogMoneyTitle = '编辑团队佣金';
        }else if(type == 16){
          this.dialogMoneyTitle = '编辑碳票';
        }else if(type == 17){
          this.dialogMoneyTitle = '编辑碳汇';
        }else if(type == 18){
          this.dialogMoneyTitle = '编辑可提现金额';
        }else{
          this.dialogMoneyTitle = '编辑冻结余额';
        }
        this.moneyDialogVisible = true;

      },
      onMoneySubmit:function(){
        //这里要修改方法
        getMoneyEditApi({
          money_change_type: this.money_change_type,
          uid:this.moneyForm.id,
          change_money:this.change_money,
          money_status:this.money_status,//90可用余额   91冻结余额 93 积分  11 可购买商品金额
        }).then(res => {
          if(res.code === 1){
            this.moneyDialogVisible = false;
            this.$message({
              message:'操作成功',
              type: 'success'
             });
            this.getUserList()
            //this.handleCurrentChange(this.current);
          }
        })
      },

      handleCurrentChangeRecharge:function(index){
        this.currentRecharge = index;
        getMoneyListApi({
          page: index,
          uid:this.uid,
          status:this.status,
          class: this.moneyType
        }).then(res => {
          this.rechargeList = res.data.data;
          this.allpageRecharge = res.data.total;
          this.showRechargeVisible = true;
        })
      },
      handleCurrentChange: function(index) {
        this.current = index;
        getUserListApi({
          page: index,
          limit: this.pageSize,
        }).then(res => {
          this.roleList = res.data.data;
          this.allpage = res.data.total;
        })
      },
      handleSizeChange(val) {
        this.pageSize = val;
        this.current = 1;
        this.getUserList();
      },
      getUserList() {
        this.searchParameter.page = this.current;
        getUserListApi({...this.searchParameter, limit: this.pageSize}).then(res => {
          this.roleList = res.data.data
          this.allpage = res.data.total;
        })
      },
      search() {
        this.getUserList()
      },

      loadNode(node, resolve) {
        if (node.level === 0) {
          return resolve([{
              name: '监控中心'
            },
            {
              name: '文章管理'
            },
            {
              name: '用户管理'
            },
            {
              name: '菜单管理'
            },
            {
              name: '个性设置'
            },
            {
              name: '异常管理'
            },
            {
              name: '系统设置'
            },
          ]);
        }
        if (node.level > 3) return resolve([]);

        var hasChild;
        if (node.data.name === 'region1') {
          hasChild = true;
        } else if (node.data.name === 'region2') {
          hasChild = false;
        } else {
          hasChild = Math.random() > 0.5;
        }

        setTimeout(() => {
          var data;
          if (hasChild) {
            data = [{
              name: 'zone' + this.count++
            }, {
              name: 'zone' + this.count++
            }];
          } else {
            data = [];
          }

          resolve(data);
        }, 500);
      },
    },
  }
</script>

<style lang='scss' scoped>
  .page-content {
    width: 100%;
    height: 100%;
    position: absolute !important;
    overflow: auto !important;
  }
  >>> .el-table::-webkit-scrollbar {
    width: 8px !important; /*滚动条宽度*/
    height: 8px !important; /*滚动条高度*/
  }
  >>> .el-table__body-wrapper::-webkit-scrollbar {
    width: 8px !important; /*滚动条宽度*/
    height: 8px !important; /*滚动条高度*/
  }
  >>> .el-table__body-wrapper::-webkit-scrollbar-track {
    border-radius: 10px; /*滚动条的背景区域的圆角*/
    -webkit-box-shadow: inset 0 0 6px rgba(238,238,238, 0.3);
    background-color: #eeeeee; /*滚动条的背景颜色*/
  }
  >>> .el-table__body-wrapper::-webkit-scrollbar-thumb {
    border-radius: 10px; /*滚动条的圆角*/
    -webkit-box-shadow: inset 0 0 6px rgba(145, 143, 0143, 0.3);
    background-color: rgb(145, 143, 143); /*滚动条的背景颜色*/
  }
  .verification-box{
    width:300px;
    height: 150px;
    position:absolute;
    top:50%;
    left:50%;
    margin-top:-100px;
    margin-left:-200px;
  }
</style>
