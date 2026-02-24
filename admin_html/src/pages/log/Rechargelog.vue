<template>
  <div class='page-content'>
    <el-row :gutter="20" style="heigth:40px;margin-bottom:10px">
        <!-- <el-col :xs="24" :sm="12" :lg="6">
            <el-radio-group v-model="searchParameter.number">
                <el-radio :label="1">本地货币</el-radio>
                <el-radio :label="2">USDT</el-radio>
            </el-radio-group>

      </el-col> -->
      <!-- <el-col :xs="24" :sm="12" :lg="4">
            <el-select v-model="searchParameter.type" style="width:100%" placeholder="请选择">
                <el-option key="" label="全部" value=""></el-option>
                <el-option key="1" label="PHP" :value="1"></el-option>
                <el-option key="2" label="USDT" :value="2"></el-option>
            </el-select>
        </el-col> -->
        <el-col :xs="24" :sm="12" :lg="4">
            <el-select v-model="searchParameter.status" style="width:100%" placeholder="请选择">
                <el-option key="" label="全部" value=""></el-option>
                <el-option key="0" label="待处理" :value="0"></el-option>
                <el-option key="1" label="通过" :value="1"></el-option>
                <el-option key="2" label="拒绝" :value="2"></el-option>
            </el-select>
        </el-col>
      <el-col :xs="24" :sm="12" :lg="4">
        <el-input placeholder="用户名称" v-model="searchParameter.user_name"></el-input>
      </el-col>
      <el-col :xs="24" :sm="12" :lg="4">
        <el-input placeholder="用户ID" v-model="searchParameter.uid"></el-input>
      </el-col>
      <el-col :xs="24" :sm="12" :lg="4">
        <el-input placeholder="订单号" v-model="searchParameter.order_on"></el-input>
      </el-col>

      <!-- <el-col :xs="24" :sm="12" :lg="5">
               <el-date-picker
                 v-model="searchParameter.start"
                 type="date"
                 placeholder="开始日期">
               </el-date-picker>
       </el-col>
       <el-col :xs="24" :sm="12" :lg="5">
               <el-date-picker
                 v-model="searchParameter.end"
                 type="date"
                 placeholder="结束日期">
               </el-date-picker>
       </el-col> -->
      <!-- <el-col :xs="24" :sm="12" :lg="3" v-if="myInfo.role !== 2">
        <el-select clearable v-model="searchParameter.agents"  :placeholder="String(searchParameter.agents) ? String(searchParameter.agents) : '全部'"  @change="handleDailiRanking($event)"
                   :style="{width: '100%'}">
          <el-option v-for="(item,index) in dailishangData" :key="index" :label="item.user_name" :value="item.id">
          </el-option>
        </el-select>
      </el-col> -->
    </el-row>
    <el-row :gutter="20" >
      <!-- <el-col :xs="24" :sm="12" :lg="6">
        <el-radio-group v-model="searchParameter.status">
            <el-radio :label="0">待处理</el-radio>
            <el-radio :label="1">通过</el-radio>
            <el-radio :label="2">拒绝</el-radio>
        </el-radio-group>
      </el-col> -->
        <el-col :xs="24" :sm="12" :lg="4" class="el-col2">
            <el-button @click="search">搜索</el-button>
        </el-col>
    </el-row>

    <el-table height="600px" style="margin-top: 15px" border :data="roleList" :showPage="false">


      <el-table-column label="ID" prop="id"/>

     <!-- <el-table-column width="100" label="充值类型" prop="type">
        <template slot-scope="scope">
          <span style="">{{scope.row.type==1?'本地货币':'USDT'}}</span>
        </template>
      </el-table-column> -->

      <el-table-column width="100" label=" ID/用户/号码" prop="user_name">
        <template slot-scope="scope">
          <span style="color: blue;">{{scope.row.rebeccapurple}}</span>
          <br>
          <span style="color: blue;">{{scope.row.user_name}}</span>
          <br>
          <span style="color: red;">{{scope.row.phone}}</span>
        </template>
      </el-table-column>

      <el-table-column label="充值金额" prop="money"/>
      <el-table-column label="余额" prop="after_balance"/>
      <el-table-column label="订单号" prop="order_no"/>
      <el-table-column label="平台订单号" prop="trilateral_order"/>
      <el-table-column label="管理员" prop="admin_name"/>
      <el-table-column width="200" label=" 充值时间" prop="create_time"/>
      <el-table-column width="200" label=" 处理时间" prop="success_time">
        <template slot-scope="scope">
          <span style="color: blue;">{{scope.row.success_time}}</span>
        </template>
      </el-table-column>
      <el-table-column label="IP" prop="u_ip"/>
      <el-table-column width="100" label="状态" prop="status">
        <template slot-scope="scope">
          <span type="" style="" v-if="scope.row.status==0">创建订单</span>
          <el-button type="text" size="mini" v-if="scope.row.status==1">待支付</el-button>
          <el-button type="text" size="mini" v-if="scope.row.status==2">支付成功</el-button>
          <el-button type="text" size="mini" v-if="scope.row.status==3">支付失败</el-button>
        </template>
      </el-table-column>
      <el-table-column label="打款账户" prop="u_bank_name"/>

      <!-- <el-table-column label="地区" prop="u_city"/> -->
      <el-table-column label="收款账号" prop="sys_bank_id"/>
      <el-table-column label="打款用户名" prop="u_bank_user_name"/>
      <el-table-column label="打款账户卡号" prop="u_bank_card"/>
      <el-table-column fixed="right" label="操作" width="100px">
        <template slot-scope="scope" v-if="scope.row.status == 0 || scope.row.status == 1">
            <div class="page-btns" style="margin-top:5px">
                <el-button type="success" plain  style="color:green" size="mini" @click="handlePassRefuse(1,scope.row)" >
                通过
                </el-button>
            </div>
            <div class="page-btns" style="margin-top:5px">
                <el-button type="danger" plain size="mini" style="color:red" @click="handlePassRefuse(2,scope.row)">
                拒绝
                </el-button>
            </div>
        </template>
      </el-table-column>
        <!-- <template slot-scope="scope">
          <el-button type="text" icon="el-icon-edit" @click="showDialog(scope.row)" v-if="scope.row.status==0">
            设置
          </el-button>
        </template> -->
      <!-- </el-table-column> -->
      <!-- <el-table-column label=" 业务员" prop="market_name"/> -->
    </el-table>


    <template v-if="allpage>10">
            <el-pagination @current-change="handleCurrentChange"
                           :current-page="1"
                           :page-size="10"
                           layout="total, prev, pager, next, jumper"
                           :total="allpage">
            </el-pagination>
        </template>


        <el-dialog :title="dialogTitle" width="500px" :visible.sync="dialogVisible" >
            <el-form ref="form" :model="form" label-width="80px">
                <el-form-item label="处理方式">
                    <el-radio-group v-model="form.status" >
                        <el-radio :label="1">通过</el-radio>
                        <el-radio :label="2">拒绝</el-radio>
                    </el-radio-group>
                </el-form-item>
                <!-- <el-form-item label="拒绝理由" v-if="form.status==2">
                    <el-input v-model="form.desc"></el-input>
                </el-form-item> -->
            </el-form>

            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="onSubmit()">确 定</el-button>
            </span >
        </el-dialog>

  <!--  点击通过修改金额弹出框-->
    <el-dialog
      title="修改金额"
      :visible.sync="updateMoneydialogVisible"
      center
      width="20%">
      <div style="display: flex;margin: 0 auto;width: 80%;align-items: center;">
        <span style="width: 100px;">修改金额：</span>
        <el-input type="text" placeholder="请输入修改金额" v-model="updateMoneyValue" style="width: 90%;"></el-input>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button @click="updateMoneydialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="updateMoneyDialogSubmit">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
   import {getRechargeListApi,getRechargeRefuseApi,getRechargePassApi,getactionCon,getDaiLiShangData} from '@/api/MoneylogApi'
  export default {
    data () {
      return {
        updateMoneyValue: '',
        updateMoneydialogVisible: false,
        allpage:1,//总页数
        showItem:5,//分页显示得中间按钮个数
        current:1,//当前页
        dvEdit: false,
        dialogVisible:false,
        dialogTitle: '充值处理',
        form: {
          username: '',
          desc: '',
          status: false
        },
        searchParameter: {
          user_name: undefined,
          number: '',
          status: '',
          agents: ''
        },
        props: {
          label: 'name',
          children: 'zones'
        },
        count: 1,
        roleList: [],
        actionConData: [],
        passBtnFlag: false,
        refuseBtnFlag: false,
        dailishangData: [],
        myInfo: {},
        updateMoneyType: '',
        updateMoneyRow: {}
      };
    },
    mounted() {
      this.getUserList()
      this.getactionConFun()
      this.getDaiLiShangData()
      // 获取账号信息
      this.myInfo = JSON.parse(localStorage.getItem('myInfo'))
    },
    methods: {
      // 修改金额弹框确定事件
      updateMoneyDialogSubmit() {
        getRechargePassApi({id: this.updateMoneyRow.id,money: this.updateMoneyValue}).then(res => {
          if(res.code == 1){
            this.$message({message:res.msg,type: 'success'});
            this.dialogVisible = false
            this.handleCurrentChange(this.current)
            this.updateMoneydialogVisible = false
          }
        })
      },

      // 代理商选择处理事件
      handleDailiRanking(e) {
        this.searchParameter.agents = e;
        getRechargeListApi(this.searchParameter).then(res => {
          this.roleList = res.data.data
          this.allpage = res.data.total;
          console.log(res.data)
        })
      },

      // 获取代理商数据
      getDaiLiShangData() {
        getDaiLiShangData({
          agents: this.searchParameter.agents
        }).then(res => {
          console.log(res);
          this.dailishangData = res.data
        })
      },

      // 获取action/con权限数据
      getactionConFun() {
        getactionCon().then(res => {
          if (res.code === 1) {
            this.actionConData = res.data
            for (let item of this.actionConData) {
              if (item.path === '/recharge/pass') this.passBtnFlag = true
              if (item.path === '/recharge/refuse') this.refuseBtnFlag = true
            }
          }
        })
      },
      handleCurrentChange:function(index){
        this.current = index;
        this.searchParameter.page = index;
        getRechargeListApi(this.searchParameter).then(res => {
            this.roleList = res.data.data;
            this.allpage = res.data.total;
        })
      },

      getUserList(){
        if(this.$route.query.id >0){
          this.searchParameter.id = this.$route.query.id
        }
        getRechargeListApi(this.searchParameter).then(res => {
          this.roleList = res.data.data
           this.allpage = res.data.total;
          console.log(res.data)
        })

      },
      search() {
        this.getUserList()
      },
      showDialog(type) {
        this.dvEdit = true
        this.dialogTitle = type === 'add' ? '新增' : '编辑'
      },
      onSubmit() {
        console.log('this.',this.form.status)
        if(this.form.status == 0) {
            this.$$message({
                message: '请选择处理方式'
            })
            return
        }
        if(this.form.status == 1) {
            getRechargePassApi({id: this.form.id}).then(res => {
                if(res.code == 1){
                    this.$message({message:res.msg,type: 'success'});
                    this.dialogVisible = false
                    return;
                }
            })
            return
        }
        if(this.form.status == 2) {
            getRechargeRefuseApi({id: this.form.id}).then(res => {
                if(res.code == 1){
                    this.$message({message:res.msg,type: 'success'});
                    this.dialogVisible = false
                    return;
                }
            })
        }
      },
      handlePassRefuse(type,rowData) {
        // console.log('this.',this.form.status)
        // if(this.form.status == 0) {
        //     this.$$message({
        //         message: '请选择处理方式'
        //     })
        //     return
        // }

        if(type == 1) {
          this.updateMoneydialogVisible = true
          this.updateMoneyType = type
          this.updateMoneyRow = rowData
          this.updateMoneyValue = this.updateMoneyRow.money
          return
        }
        if(type == 2) {
          getRechargeRefuseApi({id: rowData.id,status:type}).then(res => {
            if(res.code == 1){
              this.$message({message:res.msg,type: 'success'});
              this.dialogVisible = false
              this.getUserList()
              return;
            }
          })
        }
      },
      handleStatusChange(data){
        console.log("this.",this.form.status)
      },
      handleCheckChange(data, checked, indeterminate) {
        // console.log(data, checked, indeterminate);
      },
      handleNodeClick(data) {
        // console.log(data);
      },
      showDialog(row) {
        this.form = row
        this.dialogVisible = true;
      },
      loadNode(node, resolve) {
        if (node.level === 0) {
          return resolve([
            { name: '监控中心' },
            { name: '文章管理' },
            { name: '用户管理' },
            { name: '菜单管理' },
            { name: '个性设置' },
            { name: '异常管理' },
            { name: '系统设置' },
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
          getAgentDelApi({'id':scope.id}).then(res=>{
                if(res.code == 1){
                   this.$message({message:'删除成功',type: 'success'});
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
  }
  .page-btns{
    display: flex;
    justify-content: center;
    align-items: center;
  }
</style>
