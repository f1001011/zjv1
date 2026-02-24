<template>
  <div class='page-content'>
    <el-row :gutter="20">
      <el-col :xs="24" :sm="12" :lg="3">
        <el-input placeholder="用户名称" v-model="searchParameter.user_name"></el-input>
      </el-col>
      <el-col :xs="24" :sm="12" :lg="3">
        <el-input placeholder="用户ID" v-model="searchParameter.uid"></el-input>
      </el-col>
      <el-col :xs="24" :sm="12" :lg="4">
        <el-input placeholder="订单号" v-model="searchParameter.order_on"></el-input>
      </el-col>
      <el-col :xs="24" :sm="12" :lg="3">
            <el-select v-model="searchParameter.status" style="width:100%" placeholder="状态选择">
                <el-option key="3" label="已拒绝" value="2"></el-option>
                <el-option key="1" label="已提现" value="1"></el-option>
                <el-option key="2" label="审核中" value="0"></el-option>
            </el-select>
        </el-col>
        <el-col :xs="24" :sm="12" :lg="3">
              <el-select v-model="searchParameter.pay_type" style="width:100%" placeholder="提现方式选择">
                  <el-option key="1" label="个人提现" value="1"></el-option>
                  <el-option key="2" label="团队提现" value="2"></el-option>
              </el-select>
          </el-col>

      </el-col>
    </el-row>
    <el-row>
      <el-col :xs="24" :sm="12" :lg="6" class="el-col2" style="margin-top: 10px;">
        <el-button @click="search">搜索</el-button>
        <el-button @click="IsExcel">导出</el-button>
        <el-button @click="expand(false)" v-if="is_show">关闭</el-button>
        <el-button @click="expand(true)" v-else>展开</el-button>
      </el-col>
    </el-row>
    <el-table height="500px" style="margin-top: 15px" border  :data="roleList" :showPage="false" @selection-change="handleSelectionChange">
      <el-table-column type="selection" label="ID" prop="id" :selectable='selectEnable'/>
      <el-table-column width="100" label=" 用户 / 号码" prop="user_name">
        <template slot-scope="scope">
          <span style="color: rebeccapurple;">{{scope.row.u_id}}</span>
          <br>
          <span style="color: blue;">{{scope.row.user_name}}</span>
          <br>
          <span style="color: red;">{{scope.row.phone}}</span>
        </template>
      </el-table-column>
      <!-- <el-table-column label="开始金额"  prop="money_before"/> -->
      <el-table-column label="提现金额" prop="money" width="80" />
      <!-- <el-table-column label="结束金额" prop="money_end"/> -->
      <el-table-column label="手续费" prop="money_fee" width="80"/>
      <el-table-column label="实际到账金额" prop="money_actual" width="80" />
      <el-table-column label="订单编号" prop="order_on" width="120"/>
      <el-table-column label="状态" width="80" prop="status" style="color: red;">
        <template slot-scope="scope">
            <div>{{scope.row.status ==1?'通过':(scope.row.status ==2?"拒绝":'待处理')}}</div>
        </template>
     </el-table-column>

      <!-- <el-table-column label="状态描述" prop="text"/> -->
      <!-- <el-table-column label="收款名" prop="u_bank_user_name"/> -->
      <el-table-column label="申请时间" width="100" prop="create_time" v-if="is_show"/>
      <el-table-column label="到账时间" width="100" prop="success_time" v-if="is_show"/>
      <!-- <el-table-column label="管理员ID" prop="admin_name"/> -->
      <!-- <el-table-column label="用户地区" prop="u_city"/>
      <el-table-column label="支付方式" prop="pay_type"/> -->
   <!--   <el-table-column label="是否提交到平台" prop="is_status" >
         <template slot-scope="scope">
             <div style="color: red;">{{scope.row.is_status ==1 ? '已提交' : '没提交'}}</div>
         </template>
      </el-table-column> -->
      <el-table-column label="收款银行" width="100" prop="u_bank_name"/>
      <el-table-column label="收款账号" width="150" prop="u_back_card"/>
      <el-table-column label="收款名" width="80" prop="u_back_user_name"/>
      <!-- <el-table-column label="业务员" prop="market_name"/> -->
      <!-- <el-table-column label="用户IP" prop="u_ip"/> -->
      <!-- <el-table-column label="打款方式" prop="is_online">
        <template slot-scope="scope">
            <div>{{scope.row.is_online ==1?'线上打款':(scope.row.is_online ==2?"线下打款":'未处理')}}</div>
        </template>
      </el-table-column> -->
      <el-table-column label="备注" width="100" prop="msg"/>
      <el-table-column width="100" label=" 审核操作" prop="success_time">
        <template slot-scope="scope" v-if="scope.row.status==0">
            <div class="page-btns">
                <el-button type="success" plain style="color:green" size="mini" @click="setPayPass(scope.row)">
                    通过
                </el-button>
            </div>
            <div class="page-btns" style="margin-top:5px">
                <el-button type="danger" plain size="mini" style="color:red" @click="setPayRefuse(scope.row)">
                    拒绝
                </el-button>
            </div>
          <div class="page-btns" style="margin-top:5px" v-if="amountFlag">
            <el-button type="danger" plain size="mini" style="color:red" @click="updateMoney(scope.row)">
              修改金额
            </el-button>
          </div>
        </template>
      </el-table-column>
      <!-- <el-table-column width="100" fixed="right" label=" 审核操作" prop="success_time">
        <template slot-scope="scope" v-if="scope.row.is_online == 0 && scope.row.status == 1">
        <template slot-scope="scope" v-if="scope.row.status == 1">
            <div class="page-btns">
                <el-button type="primary" plain size="mini" @click="setPayIsLine(1,scope.row)">
                    线上打款
                </el-button>
            </div>
            <div class="page-btns" style="margin-top:5px">
                <el-button type="primary" plain size="mini" @click="setPayIsLine(2,scope.row)">
                    线下打款
                </el-button>
            </div>
        </template>
      </el-table-column> -->
      <!-- <el-table-column fixed="right" label="操作" width="150px">
          <template slot-scope="scope">
            <el-button type="text" icon="el-icon-edit" @click="showDialog('edit',scope.row)">
              提现确认
            </el-button>
          </template>
        </el-table-column> -->
    </el-table>

    <el-dialog :title="dialogTitle" width="500px" :visible.sync="dvEdit">
      <el-form ref="form" :model="form" label-width="80px">
         <el-form-item label="订单状态">
             <el-radio-group v-model="form.status" size="medium">
               <el-radio  :key="1" label="1">提现成功</el-radio>
               <el-radio  :key="2" label="2">拒绝提现</el-radio>
             </el-radio-group>
           </el-form-item>
           <el-form-item label="拒绝理由">
             <el-input v-model="form.msg" placeholder="请拒绝理由(拒绝时候填写)"></el-input>
           </el-form-item>
       </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dvEdit = false">取 消</el-button>
        <el-button type="primary" @click="onSubmit">确 定</el-button>
      </span>
    </el-dialog>
    <template v-if="allpage>20">
            <el-pagination @current-change="handleCurrentChange"
                           :current-page="1"
                           :page-size="20"
                           layout="total, prev, pager, next, jumper"
                           :total="allpage">
            </el-pagination>
        </template>
  <!-- 修改金额弹出框 -->
    <el-dialog
      title="修改手续费与实际到账金额"
      :visible.sync="updateMoneyFlag"
      center
      width="25%">
      <div class="input">
        <div>
          <span>手续费：</span>
          <el-input v-model="shouxufei" placeholder="请输入手续费"></el-input>
        </div>
        <div style="margin-top: 10px;">
          <span>实际到账金额：</span>
          <el-input v-model="shijiMoeny" placeholder="请输入实际到账金额"></el-input>
        </div>
      </div>
      <span slot="footer" class="dialog-footer">
    <el-button @click="updateMoneyFlag = false">取 消</el-button>
    <el-button type="primary" @click="submitUpdateMoney">确 定</el-button>
  </span>
    </el-dialog>
  </div>
</template>

<script>
    import { baseUrl } from '../../utils/config.js';
    import {getToken} from "../../utils/auth.js"
   import {ExcelPayListApi,getPayListApi,gettPayStatusApi,setPayRefuseApi,setPayPassApi,setPayIsLineApi,getactionCon,setUpdateMoney,getDaiLiShangData} from '@/api/MoneylogApi'
  export default {
    data () {
      return {
        tableItemData: {},
        shouxufei: '',
        shijiMoeny: '',
        updateMoneyFlag: false,
        allpage:1,//总页数
        showItem:5,//分页显示得中间按钮个数
        current:1,//当前页
        dvEdit: false,
        dialogTitle: '',
        money_change_type:'',
        form: {},
        searchParameter: {
          user_name: undefined,
          status: undefined,
          pay_type:undefined,
        },
        props: {
          label: 'name',
          children: 'zones'
        },
        is_show:false,
        is_excel:0,
        count: 1,
        roleList: [],
        passBtnFlag: false,
        refuseBtnFlag: false,
        daMoneyFlag: false,
        selectVal: [], // 多选数据
        selectPassFlag: false,
        selectRefuseFlag: false,
        amountFlag: false,
        myInfo: {},
        dailishang: '',
        dailishangData: [],
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
      // 代理商选择事件
      handleDailiRanking(e) {
        this.dailishang = e
        getPayListApi({status:this.searchParameter.status,'user_name': this.searchParameter.user_name,agents: this.dailishang}).then(res => {
          this.roleList = res.data.data
          for (let item of this.roleList) {
            if (item.type === 1) {
              item.type = '本地货币'
            } else {
              item.type = 'USDT'
            }
          }
          this.allpage = res.data.total;
          console.log(res.data)
        })
      },
      // 获取代理商数据
      getDaiLiShangData() {
        getDaiLiShangData({
          agents: this.dailishang
        }).then(res => {
          console.log(res);
          this.dailishangData = res.data
        })
      },
      expand(bool){
        this.is_show = bool;
      },
      // 多选通过事件
      selectPass() {
        if (this.selectVal.length === 0) {
          this.$message.info('请选择数据!')
          return
        }
        let ids = []
        for (let item of this.selectVal) {
          ids.push(item.id)
        }
        ids = ids.join(',')
        setPayPassApi({ id: ids }).then(res => {
          if (res.code === 1) {
            this.$message.success(res.msg)
            this.getUserList()
          } else {
            this.$message.error(res.msg)
          }
        })
      },
      // 多选拒绝事件
      selectRefuse() {
        if (this.selectVal.length === 0) {
          this.$message.info('请选择数据!')
          return
        }
        let ids = []
        for (let item of this.selectVal) {
          ids.push(item.id)
        }
        ids = ids.join(',')
        setPayRefuseApi({ id: ids }).then(res => {
          if (res.code === 1) {
            this.$message.success(res.msg)
            this.getUserList()
          } else {
            this.$message.error(res.msg)
          }
        })
      },
      // 表格多选事件
      handleSelectionChange(val) {
        this.selectVal = val
      },
      // 判断数据是否处理过，处理过的则禁用，未处理过的则可以多选
      selectEnable(row, rowIndex) {
        if (row.status !== 0) {
          return false //禁用
        } else {
          return true// 不禁用
        }

      },
      // 提交修改后的手续费与实际到账金额
      submitUpdateMoney() {
        setUpdateMoney({
          id: this.tableItemData.id,
          money_fee: this.shouxufei,
          money_actual: this.shijiMoeny
        }).then(res => {
          if (res.msg === 'ok') {
            this.$message.success('修改成功!')
            this.getUserList()
            this.updateMoneyFlag = false
          } else {
            this.$message.error('修改失败!')
          }
        })
      },
      // 修改金额按钮事件
      updateMoney(item) {
        this.tableItemData = item
        this.shouxufei = item.money_fee
        this.shijiMoeny = item.money_actual
        this.updateMoneyFlag = true
      },
      // 获取action/con权限数据
      getactionConFun() {
        getactionCon().then(res => {
          if (res.code === 1) {
            this.actionConData = res.data
            for (let item of this.actionConData) {
              if (item.path === '/recharge/pass') this.passBtnFlag = true
              if (item.path === '/recharge/refuse') this.refuseBtnFlag = true
              if (item.path === '/pay/is_line') this.daMoneyFlag = true
              if (item.path === '/pay/pass') this.selectPassFlag = true
              if (item.path === '/pay/refuse') this.selectRefuseFlag = true
              if (item.path === '/pay/amount') this.amountFlag = true
            }
          }
        })
      },
      changes(status,row){
          gettPayStatusApi({
            id:row.id,
            status:status,
            }).then(res => {
            if(res.code == 1){
             this.$message({message:res.msg,type: 'success'});
             this.getUserList()
              return;
            }
          })
      },
      setPayPass(row) {
        let data = {
            id: row.id
        }
        setPayPassApi(data).then(res => {
            if(res.code == 1){
             this.$message({message:res.msg,type: 'success'});
             this.getUserList()
              return;
            }
        })
      },
      setPayRefuse(row) {
        this.$confirm('您确定要拒绝提现吗', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'error'
        }).then(() => {
            let data = {
                id: row.id,
                msg: ''
            }
            setPayRefuseApi(data).then(res => {
                if(res.code == 1){
                this.$message({message:res.msg,type: 'success'});
                this.getUserList()
                return;
                }
            })
        }).catch(() => {})

      },

      setPayIsLine(lineType,row){
        let data = {
            id: row.id,
            is_online: lineType
        }
        setPayIsLineApi(data).then(res => {
            if(res.code == 1){
             this.$message({message:res.msg,type: 'success'});
             this.getUserList()
              return;
            }
        })
      },
      handleCurrentChange:function(index){
                this.is_excel = 0;
                this.current = index;
                getPayListApi({
                  page:index,
                }).then(res => {
                  this.roleList = res.data.data;
                  for (let item of this.roleList) {
                    if (item.type === 1) {
                      item.type = '本地货币'
                    } else {
                      item.type = 'USDT'
                    }
                  }
                  this.allpage = res.data.total;
                })
      },

      getUserList(){
        getPayListApi({uid:this.searchParameter.uid,pay_type:this.searchParameter.pay_type,status:this.searchParameter.status,'user_name': this.searchParameter.user_name,'is_excel':this.is_excel,'page':this.current}).then(res => {
          this.roleList = res.data.data
          for (let item of this.roleList) {
            if (item.type === 1) {
              item.type = '本地货币'
            } else {
              item.type = 'USDT'
            }
          }
           this.allpage = res.data.total;
          console.log(res.data)
        })
      },


      search() {
        this.is_excel = 0;
        this.getUserList()
      },
      IsExcel(){
        if (this.selectVal.length === 0) {
          this.$message.info('请要导出的数据!')
          return
        }
        this.is_excel = 1;
        var ids = [];
        for(var i = 0; i < this.selectVal.length; i++){
            ids.push(this.selectVal[i].id)
        }
        console.log(ids.join(','));

        let canshu = baseUrl+'/pay/list?ids='+ids.join(',')+'&is_excel=1&token='+getToken()
        window.location.href = canshu
      },
      showDialog(type,row) {
        this.dvEdit = true
      if(type == 'edit'){
            this.form = row;
            this.form.status=row.status.toString();
        }

        this.dialogTitle = type === 'add' ? '新增' : '编辑'
      },
      onSubmit() {
        this.dvEdit = false
      gettPayStatusApi(this.form).then(res => {
            if(res.code == 1){
               this.$message({message: '修改成功',type: 'success'});
               this.dvEdit = false
               this.handleCurrentChange(this.current);
                return;
              }
            return;
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
                  this.getUserList()
                }
          })
        }).catch(() => {})
      }
    },
  }
</script>

<style lang='scss' scoped>
  /* .page-content {
    width: 100%;
    height: 100%;
  } */
  .page-btns{
    display: flex;
    justify-content: center;
    align-items: center;
  }
  >>> .el-dialog__header {
    border: none;
  }
  >>> .el-dialog__footer {
    border: none;
  }
  .input {
    width: 100%;
    text-align: center;
    div {
      width: 80%;
      display: flex;
      align-items: center;
      margin: 0 auto;
      span {
        width: 100px;
        text-align: right;
      }
      .el-input {
        width: 60%;
        margin-left: 3px;
      }

    }
  }

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
