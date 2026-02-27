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
         <el-col :xs="24" :sm="12" :lg="4">
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
         </el-col>
       </el-row>
       <el-row :xs="24" :sm="12" :lg="6" style="margin-top: 10px;">
         <el-button @click="search">搜索</el-button>
         <el-button @click="showDialog('add')" v-if="addBtnFlag">新增用户</el-button>
         <el-button @click="selectPass(2)">身份证多选通过</el-button>
         <el-button @click="selectPass(3)">身份证多选拒绝</el-button>
         <el-button @click="expand(false)" v-if="is_show">关闭</el-button>
         <el-button @click="expand(true)" v-else>展开</el-button>
       </el-row>
     </el-form>
   </div>

    <el-table height="80vh" style="width: 100%;margin-top: 15px;" border :data="roleList" :showPage="false" @selection-change="handleSelectionChange" :key="Math.random()">
      <el-table-column type="selection" label="ID" prop="id" :selectable='selectEnable'/>
      <el-table-column label="ID" width="65" prop="id" />
      <el-table-column label="用户电话" width="95" prop="phone" />
      <el-table-column label="用户名称" width="80" prop="user_name" />
      <!-- <el-table-column label="用户昵称" width="120" prop="nickname" /> -->
      <el-table-column label="银行卡充值" width="100" prop="money_purchase"/>
      <el-table-column label="个人总收益" width="100" prop="money_balance"/>

      <!-- <el-table-column label="累积充值" width="100" prop="total_recharge" >
        <template slot-scope="scope"> -->
          <!-- <el-button type="primary" @click="showRechargeList(scope.row,101,1)" :disabled="!tableBtnFlag">{{scope.row.total_recharge}}</el-button> -->
        <!--  <el-button type="primary" :disabled="!tableBtnFlag">{{scope.row.total_recharge}}</el-button>
        </template>
      </el-table-column> -->
      <!-- <el-table-column label="冻结金额" width="100" prop="money_freeze">
        <template slot-scope="scope">
          <el-button type="primary" :disabled="!tableBtnFlag">{{scope.row.money_freeze}}</el-button>
        </template>
      </el-table-column> -->
      <!-- <el-table-column label="累计提现" width="100" prop="total_withdraw" >
        <template slot-scope="scope">
          <el-button type="primary" :disabled="!tableBtnFlag">{{scope.row.total_withdraw}}</el-button>
        </template>
      </el-table-column> -->
      <el-table-column label="(下级购买返佣总数+津贴)" width="80" prop="money_hire"/>
      <!-- <el-table-column label="团队津贴(个人佣金+工资)" width="110" prop="money_team"/> -->

      <el-table-column label="积分" width="80" prop="money_integral" v-if="is_show"/>
      <el-table-column label="绿币" width="80" prop="money_green" v-if="is_show"/>

      <el-table-column label="碳票" width="80" prop="money_vote" v-if="is_show"/>
      <el-table-column label="碳汇" width="80" prop="money_converge" v-if="is_show"/>
      <!-- <el-table-column label="用户股权" width="110" prop="money_thigh" >
        <template slot-scope="scope">
          <el-button type="primary" :disabled="!tableBtnFlag">{{scope.row.money_thigh}}</el-button>
        </template>
      </el-table-column> -->

      <el-table-column label="可提现金额" width="100" prop="money_approve"/>


      <el-table-column label="银行卡" width="60">
        <template slot-scope="scope">
            <el-button type="text" size="small" @click="showCheck(scope.row.id)">银行卡</el-button>
            <!-- <router-link :to="'/user/bankCard?uid='+scope.row.id">银行卡</router-link> -->
        </template>
      </el-table-column>
      <el-table-column label="冻结用户状态" width="100" prop="status">
        <template slot-scope="scope">
          <el-tag size="mini" :type="scope.row.status ? '' : 'info'">
              {{scope.row.status == 1 ? '正常' : '禁用'}}
            </el-tag>
            <el-switch   v-model="scope.row.status" @change="changes(scope.row.status,scope.row,'status')" :active-value="1" :inactive-value="0"></el-switch>
        </template>
      </el-table-column>
      <el-table-column label="上级代理商ID" width="120" prop="agent_id" v-if="is_show"/>
      <el-table-column label="所属团队号" width="120" prop="user_team" v-if="is_show"/>
      <el-table-column label="创建时间" width="120"  prop="create_time" v-if="is_show"/>
      <el-table-column label="最后登录时间" width="120"  prop="login_time"/>
      <!-- <el-table-column label="是否可提现" prop="is_withdraw">
        <template slot-scope="scope">
          <el-tag size="mini" :type="scope.row.is_withdraw ? '' : 'info'">
              {{scope.row.is_withdraw == 1 ? '正常' : '禁用'}}
            </el-tag>
            <el-switch   v-model="scope.row.is_withdraw" @change="changesWithdrawal(scope.row.is_withdraw,scope.row,'is_withdraw')" :active-value="1" :inactive-value="0"></el-switch>
        </template>
      </el-table-column> -->
      <el-table-column label="操作" width="80px">
        <template slot-scope="scope">
          <el-button type="text" icon="el-icon-edit" @click="showDialog('edit',scope.row)" v-if="updateBtnFlag">
            编辑
          </el-button>
          <el-button type="text" style="color: #FA6962" icon="el-icon-delete" @click="deleteUser(scope.row)" v-if="deleteBtnFlag">
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-dialog :title="dialogTitle" width="500px" :visible.sync="dvEdit">
      <el-form ref="form" :model="form" label-width="120px">
        <el-form-item label="姓名">
          <el-input v-model="form.user_name" placeholder="请输入姓名(必填)"></el-input>
        </el-form-item>
        <el-form-item label="手机号码">
          <el-input v-model="form.phone" placeholder="请输入手机号码(必填)"></el-input>
        </el-form-item>
        <el-form-item label="身份证">
          <el-input v-model="form.sfz" placeholder="请输入身份证(必填)"></el-input>
        </el-form-item>
        <el-form-item label="身份状态">
          <el-radio v-model="form.is_real_name" :label="0">未实名</el-radio>
          <el-radio v-model="form.is_real_name" :label="1">提交申请</el-radio>
          <el-radio v-model="form.is_real_name" :label="2">通过申请</el-radio>
          <el-radio v-model="form.is_real_name" :label="3">拒绝申请</el-radio>
        </el-form-item>
        <el-form-item label="推荐人ID">
          <el-input v-model="form.agent_id" placeholder="请输入推荐人(不填客户默认为顶级用户)"></el-input>
        </el-form-item>

        <el-form-item label="修改用户登录密码">
          <el-input v-model="form.pwd" placeholder="请输入密码(必填)"></el-input>
        </el-form-item>
        <el-form-item label="修改用户登录提现密码">
          <el-input v-model="form.withdraw_pwd" placeholder="请输入密码(必填)"></el-input>
        </el-form-item>

        <!-- <el-form-item label="可用提现金额">
          <el-input v-model="form.money_approve" readonly="" placeholder="可用提现金额"></el-input>
        </el-form-item> -->

        <!-- <el-form-item label="账号类型">
          <el-radio-group v-model="form.type" size="medium">
            <el-radio  key="1" label="1">代理</el-radio>
            <el-radio  key="2" label="2">会员</el-radio>
          </el-radio-group>
        </el-form-item> -->

        <!-- <el-form-item label="业务员ID">
          <el-input v-model="form.market_uid" placeholder="请输入业务员ID(可不填)"></el-input>
        </el-form-item> -->
        <!-- <el-form-item label="分销比例%">
          <el-input v-model="form.agent_rate"  placeholder="请输入分销比例"></el-input>
        </el-form-item> -->
        <!-- <el-form-item label="可用余额">
          <el-input v-model="form.money_balance" readonly="" placeholder="请输入可用余额"></el-input>
        </el-form-item>
        <el-form-item label="可用积分">
          <el-input v-model="form.money_integral" readonly="" placeholder="请输入积分"></el-input>
        </el-form-item>
        <el-form-item label="可用绿币">
          <el-input v-model="form.money_green" readonly="" placeholder="请输入绿币"></el-input>
        </el-form-item>
        <el-form-item label="冻结金额">
          <el-input v-model="form.money_freeze" readonly="" placeholder="请输入冻结余额"></el-input>
        </el-form-item> -->
        <el-form-item label="业务员ID" prop="market_uid"
    :rules="[
      { required: true, message: '业务员ID不能为空'},
      { type: 'number', message: '业务员ID必须为数字值'}
    ]">
      <el-input v-model.number="form.market_uid" placeholder="请输入业务员ID"></el-input>
        </el-form-item>
    <!--    <el-form-item label="可购买产品类别">
            <el-select v-model="form.product_class" multiple style="width:100%" placeholder="请选择">
                <el-option :key="index" :label="item.name" :value="item.id" v-for="(item,index) in dataClassList"></el-option>
            </el-select>
        </el-form-item> -->
        <!-- <el-form-item label="邀请码">
          <el-input v-model="form.invitation_code" disabled placeholder="请输入邀请码(可不填)"></el-input>
        </el-form-item>
        <el-form-item label="手机号">
          <el-input v-model="form.phone" disabled placeholder="请输入手机号(可不填)"></el-input>
        </el-form-item> -->

       <!-- <el-form-item label="是否虚拟账号">
          <el-input v-model="form.is_fictitious" placeholder="1是 0不是"></el-input>
        </el-form-item> -->
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dvEdit = false">取 消</el-button>
        <el-button type="primary" @click="onSubmit">确 定</el-button>
      </span>
    </el-dialog>

    <el-dialog :title="infotitle" width="50%" :visible.sync="showRechargeVisible">
      <tao-table style="margin-top: 15px" :data="rechargeList" :showPage="false">
        <el-table-column label="ID" prop="id"  width="50%"/>
        <el-table-column label="用户名称" prop="user_name" />
        <!-- <el-table-column label="业务员" prop="admin_name" /> -->
        <el-table-column label="详细类型" prop="status" />
         <el-table-column label="变化前金额" prop="money_before" />
         <el-table-column label="变化后金额" prop="money_end" />
         <el-table-column label="变化金额" prop="money" />
         <el-table-column label="创建时间" prop="create_time" />
      </tao-table>
      <template v-if="allpageRecharge>10">
            <el-pagination @current-change="handleCurrentChangeRecharge" :currentRecharge-page="1" :page-size="10" layout="total, prev, pager, next, jumper"
              :total="allpageRecharge">
            </el-pagination>
          </template>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dvEdit = false">取 消</el-button>
        <el-button type="primary" @click="dvEdit = false">确 定</el-button>
      </span>
    </el-dialog>


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
        <el-form-item label="操作密码">
          <el-input v-model="operate_pwd" placeholder="请输入操作密码"></el-input>
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

  import {getIsWithdrawalStatusApi,getUserWithdrawalStatusApi,getUserStatusApigetUserStatusApi,getIsStatusApi,getUserListApi,getUserDelApi,getUserEditApi,getUserAddApi,getMoneyEditApi,getDailiData, getactionCon,getIdentityEdit} from '@/api/userApi'
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
        dialogTitle: '',
        infotitle:'',
        operate_pwd:'',//操作密码
        form: {
          user_name: '',
          desc: '',
        },
        is_show:false,
        searchParameter: {
          user_name: undefined,
          market_uid: undefined,
          phone: undefined,
          data_time: undefined
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
        selectVal: [], // 多选数据
        selectPassFlag: true,
        selectRefuseFlag: true,
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
      // 判断数据是否处理过，处理过的则禁用，未处理过的则可以多选
      selectEnable(row, rowIndex) {
        if (row.is_real_name > 1) {
          return false //禁用
        } else {
          return true// 不禁用
        }
      },
      // 表格多选事件
      handleSelectionChange(val) {
        let arr = this.selectVal;
        val.forEach(function(item,index,val){
          arr.push(item.id);
        })
        this.selectVal = arr;
        console.log(this.selectVal);
      },
      // 多选通过事件
      selectPass(type) {
        if (this.selectVal.length === 0) {
          this.$message.error('请选择数据')
          return
        }
        let ids = this.selectVal
        ids = ids.join(',')
        getIdentityEdit({ id: ids,type: type}).then(res => {
          if (res.code === 1) {
            this.selectVal = [];
            this.$message.success(res.msg)
            this.getUserList()
          } else {
            this.$message.error(res.msg)
          }
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
      showCheck (id) {
        this.$router.push({  // 跳转到详情页
          path: '/user/bankCard?uid='+id
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
      onMoneySubmit:function(){
        if(this.operate_pwd.length <= 0){
          this.$message({message:'操作密码不能为空',type: 'error'});
          return;
        }
        //这里要修改方法
        getMoneyEditApi({
          money_change_type: this.money_change_type,
          uid:this.moneyForm.id,
          change_money:this.change_money,
          money_status:this.money_status,//90可用余额   91冻结余额 93 积分  11 可购买商品金额
          operate_pwd:this.operate_pwd,
        }).then(res => {
          if(res.code === 1){
            this.moneyDialogVisible = false;
            this.operate_pwd = '';
            this.$message({
              message:'操作成功',
              type: 'success'
             });
             this.getUserList()
            // this.handleCurrentChange(this.current);
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
          limit: this.pageSize,
        }).then(res => {
          this.roleList = res.data.data;
          this.allpage = res.data.total;
        })
      },
      getUserList() {

        getUserListApi({...this.searchParameter, limit: this.pageSize}).then(res => {
          this.roleList = res.data.data
          this.allpage = res.data.total;
        })
      },
      expand(bool){
        this.is_show = bool;
      },
      search() {
        this.getUserList()
      },
      handleSizeChange(val) {
        this.pageSize = val;
        this.current = 1;
        this.getUserList();
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
