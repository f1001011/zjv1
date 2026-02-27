<template>
  <div class='page-content'>
    <el-row :gutter="20">
     <el-col :xs="24" :sm="12" :lg="4">
          <el-input placeholder="订单号" v-model="searchParameter.order_no"></el-input>
       </el-col>
       <el-col :xs="24" :sm="12" :lg="4">
            <el-input placeholder="产品名" v-model="searchParameter.goods_name"></el-input>
         </el-col>
         <el-col :xs="24" :sm="12" :lg="4">
              <el-input placeholder="用户名" v-model="searchParameter.uname"></el-input>
           </el-col>
           <el-col :xs="24" :sm="12" :lg="4">
                <el-input placeholder="用户ID" v-model="searchParameter.uid"></el-input>
             </el-col>
   </el-row>
   <el-row>
     <el-col :xs="24" :sm="12" :lg="4" class="el-col2" style="margin-top: 10px;">
        <el-button @click="search">搜索</el-button>
     <!-- <el-button @click="showDialog('add')">新增</el-button> -->
     </el-col>
   </el-row>

  <el-table height="80vh" style="width: 100%; margin-top: 15px" border :data="roleList" :showPage="false">
      <el-table-column label="ID" prop="id" width="65"/>
      <el-table-column width="100" label=" ID/用户/昵称" prop="user_name">
        <template slot-scope="scope">
          <span style="color: rebeccapurple;">{{scope.row.uid}}</span>
          <br>
          <span style="color: blue;">{{scope.row.uname}}</span>
          <br>
          <span style="color: red;">{{scope.row.phone}}</span>
        </template>
      </el-table-column>
      <!-- <el-table-column label="订单号" prop="order_no"/> -->
      <el-table-column label="商品分类" prop="goods_type_name"/>
      <el-table-column label="商品名称" prop="goods_name"/>
      <el-table-column label="商品天数" prop="day"/>
      <el-table-column label="订单金额" prop="order_money"/>
      <el-table-column label="商品数量" prop="order_number"/>
      <el-table-column label="创建时间" prop="create_time"/>
      <el-table-column label="状态" prop="status_text"/>
      <el-table-column label="全部分红金额" prop="total_red_money"/>
      <el-table-column label="已获得分红金额" prop="already_red_money"/>
      <el-table-column label="剩余应获得的分红" prop="surplus_red_money"/>
      <el-table-column label="总分红天数" prop="red_day"/>
      <el-table-column label="已分红的天数" prop="already_red_day"/>
      <el-table-column label="剩余分红的天数" prop="surplus_red_day"/>
      <el-table-column label="下次分红日期" prop="next_red_date"/>
      <el-table-column label="上次分红时间" prop="last_red_date"/>
      <!-- <el-table-column label="优惠卷金额" prop="coupon_money"/> -->

      <!-- <el-table-column fixed="right" label="操作" width="150px">
        <template slot-scope="scope">
          <el-button type="text" icon="el-icon-edit" @click="showDialog('edit',scope.row)" v-if="scope.row.order_status==-1">
            订单状态编辑
          </el-button>
        <el-button type="text" style="color: #FA6962" icon="el-icon-delete" @click="deleteUser(scope.row)">
            删除
          </el-button>
        </template>
      </el-table-column> -->
    </el-table>

<el-dialog :title="dialogTitle" width="500px" :visible.sync="dvEdit">
     <el-form ref="form" :model="form" label-width="80px">
        <el-form-item label="订单状态">
            <el-radio-group v-model="form.status" size="medium">
              <el-radio  :key="3" :label="3">已发货</el-radio>
              <el-radio  :key="6" :label="6">已签收</el-radio>
            </el-radio-group>
          </el-form-item>
      </el-form>

     <span slot="footer" class="dialog-footer">
        <el-button @click="dvEdit = false">取 消</el-button>
        <el-button type="primary" @click="onSubmit">确 定</el-button>
      </span>
    </el-dialog>
    <template v-if="allpage>10">
          <el-pagination @current-change="handleCurrentChange"
                @size-change="handleSizeChange"
                :current-page="1"
                :page-sizes="[10, 20, 50, 100]"
                :page-size="pageSize"
                layout="sizes, total, prev, pager, next, jumper"
                :total="allpage">
          </el-pagination>
    </template>
  </div>
</template>

<script>
    import {getOrderListNewApi,getOrderEditApi} from '@/api/OrderApi'
  export default {
    data () {
      return {
        searchParameter: {
          // agent_account: undefined,
        },
        allpage:1,//总页数
        showItem:5,//分页显示得中间按钮个数
        current:1,//当前页
        pageSize: 10,
        dvEdit: false,
        dialogTitle: '',
        form: {},
        props: {
          label: 'name',
          children: 'zones'
        },
        count: 1,
        roleList: []
      };
    },
    mounted() {
       this.getUserList()
    },
   methods: {
      changes(status,row){
          getAgentStatusApi({
            id:row.id,
            status:status,
            }).then(res => {
              if(res.code == 1){
                  this.$message({message:res.msg,type: 'success'});
                  return;
             }
          })
      },
     handleCurrentChange:function(index){
               this.current = index;
               getOrderListNewApi({
                 page:index,
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
     getUserList(){
        if(this.$route.query.id >0){
          this.searchParameter.id = this.$route.query.id
        }
       getOrderListNewApi({...this.searchParameter, limit: this.pageSize}).then(res => {
         this.roleList = res.data.data;
          this.allpage = res.data.total;
       })

     },
     search() {
       this.getUserList()
     },
      showDialog(type,row) {
        this.dvEdit = true
        if(type === 'edit') this.form  = row;
         if(type === 'add') this.form  = {};

        this.dialogTitle = type === 'add' ? '新增' : '订单状态编辑'
      },
      onSubmit() {
        if(this.form.id){
          getOrderEditApi(this.form).then(res => {

            if(res.code == 1){
             this.dvEdit = false
             this.$message({message:res.msg,type: 'success'});
             this.handleCurrentChange(this.current);
              return;
            }
            this.$message(res.message);
          })
          return;
        }
         getOrderAddApi(this.form).then(res => {
            if(res.code == 1){
             this.dvEdit = false
             this.$message({message:res.msg,type: 'success'});
             this.getUserList();
              return;
            }
            this.$message(res.message);
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
          getMarketLevelDelApi({'id':scope.id}).then(res=>{
               if(res.code == 1){
                this.$message({message:'删除成功',type: 'success'});
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
