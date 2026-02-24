<template>
  <div class='page-content'>
   <div slot="top">
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
         <!-- <el-col :xs="24" :sm="12" :lg="3">
           <el-input placeholder="业务员名称" v-model="searchParameter.market_uid"></el-input>
         </el-col> -->
        <!-- <el-col :xs="24" :sm="12" :lg="3">
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
       <!--  <el-col :xs="24" :sm="12" :lg="3" v-if="role === 1" >
           <el-select v-model="searchParameter.market_uid" placeholder="请选择代理商">
             <el-option label="全部" value=""></el-option>
             <el-option v-for="(item, index) in dailiData" :key="item.id" :label="item.user_name" :value="item.id"></el-option>
           </el-select>
         </el-col> -->
       </el-row>
       <el-row :xs="24" :sm="12" :lg="6" style="margin-top: 10px;">
         <el-button @click="search">搜索</el-button>
       </el-row>
     </el-form>
   </div>

    <el-table height="500px" style="margin-top: 15px;" border :data="roleList" :showPage="false">
      <el-table-column label="ID" width="80" prop="id" />
      <el-table-column label="用户电话" width="120" prop="phone" />
      <el-table-column label="用户名称" width="120" prop="user_name" />
      <!-- <el-table-column label="用户昵称" width="120" prop="nickname" /> -->
      <el-table-column label="银行卡充值" width="100" prop="money_purchase">
        <template slot-scope="scope">
          <el-button type="primary" @click="showMoneyDialog(scope.row,11)" >{{scope.row.money_purchase}}</el-button>
        </template>
      </el-table-column>



      <el-table-column label="上级代理商ID" width="120" prop="agent_id"/>
      <el-table-column label="所属团队号" width="120" prop="user_team"/>

      <el-table-column label="创建时间"  prop="create_time" />
    </el-table>

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
      <el-pagination @current-change="handleCurrentChange" :current-page="1" :page-size="10" layout="total, prev, pager, next, jumper"
        :total="allpage">
      </el-pagination>
    </template>
  </div>
</template>

<script>

  import {getIsWithdrawalStatusApi,getUserWithdrawalStatusApi,getUserStatusApigetUserStatusApi,getIsStatusApi,getUserListApi,getUserDelApi,getUserEditApi,getUserAddApi,getMoneyEditApi,getDailiData, getactionCon} from '@/api/userApi'
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
        dvEdit: false,
        dialogTitle: '',
        infotitle:'',
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
        showRechargeVisible:false,
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
      this.getUserList()
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

      changes(status,row,type){
        if(type == 'status'){
          getUserStatusApi({
            id:row.id,
             status:status,
            }).then(res => {
          })
          return;
        }
        getIsStatusApi({
            id:row.id,
            }).then(res => {
          })
      },
      changesWithdrawal(is_withdraw,row,type){
        if(type == 'is_withdraw'){
          getUserWithdrawalStatusApi({
            id:row.id,
            is_withdraw:is_withdraw,
            }).then(res => {
          })
          return;
        }
      },
      showMoneyDialog:function(row,type){
        this.moneyForm = row;
        this.money_change_type = '';
        this.change_money = '';
        this.money_status = type;
        if(type == 90){
          this.dialogMoneyTitle = '编辑个人总收益';
        }else if(type == 11){
          this.dialogMoneyTitle = '编辑银行卡充值';
        }else if(type == 12){
          this.dialogMoneyTitle = '编辑积分';
        }else if(type == 13){
          this.dialogMoneyTitle = '编辑绿币';
        }else if(type == 14){
          this.dialogMoneyTitle = '编辑个人佣金';
        }else if(type == 15){
          this.dialogMoneyTitle = '编辑团队津贴';
        }else if(type == 16){
          this.dialogMoneyTitle = '编辑碳票';
        }else if(type == 17){
          this.dialogMoneyTitle = '编辑碳汇';
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
      showRechargeList:function(row,status,moneyType){
        this.currentRecharge = 1;
        this.uid = row.id;
        this.status = status;
        this.moneyType = moneyType
       getMoneyListApi({
         page: this.currentRecharge,
         uid:row.id,
         status:this.status,
         class: this.moneyType
       }).then(res => {
         this.rechargeList = res.data.data;
         this.allpageRecharge = res.data.total;
         this.infotitle = status === 101 ? '充值详情' : '提现详情';
         this.showRechargeVisible = true;
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
        }).then(res => {
          this.roleList = res.data.data;
          this.allpage = res.data.total;
        })
      },
      getUserList() {
        this.searchParameter.page = this.current;
        getUserListApi(this.searchParameter).then(res => {
          this.roleList = res.data.data
          this.allpage = res.data.total;
        })
      },
      search() {
        this.getUserList()
      },
      showDialog(type, row) {
        this.dvEdit = true;
        if(type == 'edit'){
            this.form = row;
            // this.form.pwd = ''
            // let arr = [];

        }else{
            let nickname = '新用户'+ Math.round(Math.random()*100000);
            this.form = {
                'money_balance':0,
                'money_freeze':0,
            };
        }
        this.dialogTitle = type === 'add' ? '新增用户' : '编辑用户'
      },
      onSubmit() {
        if (this.form.id) {
          getUserEditApi(this.form).then(res => {
            if(res.code == 1){
               this.dvEdit = false
               this.$message({message: '编辑成功',type: 'success'});
               this.getUserList();
               // this.handleCurrentChange(this.current);
                return;
              }
            return;
          })
          return;
        }
        getUserAddApi(this.form).then(res => {
          if(res.code == 1){
           this.dvEdit = false
           this.$message({message:'新增成功',type: 'success'});
           this.getUserList();
            return;
          }
        })
      },
      handleCheckChange(data, checked, indeterminate) {
        // console.log(data, checked, indeterminate);
      },
      handleNodeClick(data) {
        // console.log(data);
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
      deleteUser(scope) {
        this.$confirm('您确定要删除当前用户吗', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'error'
        }).then(() => {
          getUserDelApi({
            'id': scope.id
          }).then(res => {
            if(res.code == 1){
             this.$message({message: '删除成功',type: 'success'});
              this.getUserList();
              return;
            }
          })
        }).catch(() => {})
      }
    },
  }
</script>

<style lang='scss' scoped>
  .page-content {
    width: 100%;
    height: 100%;
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
</style>
