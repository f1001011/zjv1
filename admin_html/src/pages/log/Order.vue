<template>
  <div class='page-content'>
    <div class="toolbar">
      <div class="toolbar-title">订单列表</div>
    </div>
    <div class="search-wrap">
      <el-row :gutter="12">
        <el-col :xs="24" :sm="12" :lg="4">
          <el-input size="small" placeholder="订单号" prefix-icon="el-icon-document" v-model="searchParameter.order_no" clearable></el-input>
        </el-col>
        <el-col :xs="24" :sm="12" :lg="4">
          <el-input size="small" placeholder="产品名" prefix-icon="el-icon-goods" v-model="searchParameter.goods_name" clearable></el-input>
        </el-col>
        <el-col :xs="24" :sm="12" :lg="4">
          <el-input size="small" placeholder="用户名" prefix-icon="el-icon-user" v-model="searchParameter.uname" clearable></el-input>
        </el-col>
        <el-col :xs="24" :sm="12" :lg="4">
          <el-input size="small" placeholder="用户ID" prefix-icon="el-icon-search" v-model="searchParameter.uid" clearable></el-input>
        </el-col>
        <el-col :xs="24" :sm="12" :lg="4">
          <el-button size="small" type="primary" icon="el-icon-search" @click="search">搜索</el-button>
        </el-col>
      </el-row>
    </div>
    <div class="table-wrap">
      <el-table height="calc(80vh - 130px)" style="width:100%" stripe :data="roleList"
        :header-cell-style="headerCellStyle" :cell-style="cellStyle">
        <el-table-column label="ID" prop="id" width="65" align="center"/>
        <el-table-column width="120" label="用户信息" prop="user_name">
          <template slot-scope="scope">
            <div class="user-cell">
              <span class="uid">ID: {{scope.row.uid}}</span>
              <span class="uname">{{scope.row.uname}}</span>
              <span class="phone">{{scope.row.phone}}</span>
            </div>
          </template>
        </el-table-column>
        <el-table-column label="商品分类" prop="goods_type_name" width="100"/>
        <el-table-column label="商品名称" prop="goods_name" min-width="120"/>
        <el-table-column label="商品天数" prop="day" width="80" align="center"/>
        <el-table-column label="订单金额" prop="order_money" width="100" align="right"/>
        <el-table-column label="商品数量" prop="order_number" width="80" align="center"/>
        <el-table-column label="创建时间" prop="create_time" width="150" align="center"/>
        <el-table-column label="状态" prop="status_text" width="90" align="center">
          <template slot-scope="scope">
            <el-tag size="mini" type="primary" effect="plain">{{scope.row.status_text}}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="全部分红" prop="total_red_money" width="90" align="right"/>
        <el-table-column label="已获分红" prop="already_red_money" width="90" align="right"/>
        <el-table-column label="剩余分红" prop="surplus_red_money" width="90" align="right"/>
        <el-table-column label="总分红天" prop="red_day" width="80" align="center"/>
        <el-table-column label="已分红天" prop="already_red_day" width="80" align="center"/>
        <el-table-column label="剩余天数" prop="surplus_red_day" width="80" align="center"/>
        <el-table-column label="下次分红" prop="next_red_date" width="120" align="center"/>
        <el-table-column label="上次分红" prop="last_red_date" width="120" align="center"/>
      </el-table>
    </div>
    <div class="pagination-wrap">
      <el-pagination @current-change="handleCurrentChange" @size-change="handleSizeChange"
        :current-page="current" :page-sizes="[10, 20, 50, 100]" :page-size="pageSize"
        layout="sizes, total, prev, pager, next, jumper" :total="allpage">
      </el-pagination>
    </div>

    <el-dialog :title="dialogTitle" width="500px" :visible.sync="dvEdit">
      <el-form ref="form" :model="form" label-width="80px">
        <el-form-item label="订单状态">
          <el-radio-group v-model="form.status" size="medium">
            <el-radio :key="3" :label="3">已发货</el-radio>
            <el-radio :key="6" :label="6">已签收</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dvEdit = false">取 消</el-button>
        <el-button type="primary" @click="onSubmit">确 定</el-button>
      </span>
    </el-dialog>
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
     headerCellStyle() {
       return { background: '#f0f4ff', color: '#303133', fontWeight: '600', fontSize: '13px', borderBottom: '2px solid #dce6ff' };
     },
     cellStyle() {
       return { fontSize: '13px', color: '#606266' };
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
.page-content { width:100%; height:100%; background:#f5f7fa; padding:16px; box-sizing:border-box; }
.toolbar { display:flex; align-items:center; background:#fff; border-radius:8px; padding:14px 20px; margin-bottom:12px; box-shadow:0 1px 6px rgba(0,0,0,0.06); }
.toolbar-title { font-size:16px; font-weight:600; color:#1a1a2e; }
.search-wrap { background:#fff; border-radius:8px; padding:16px 20px; margin-bottom:12px; box-shadow:0 1px 6px rgba(0,0,0,0.06); }
.table-wrap { background:#fff; border-radius:8px; box-shadow:0 1px 6px rgba(0,0,0,0.06); overflow:hidden; }
.pagination-wrap { display:flex; justify-content:flex-end; padding:12px 0 4px; }
.user-cell { display:flex; flex-direction:column; gap:2px; font-size:12px; }
.user-cell .uid { color:#909399; }
.user-cell .uname { color:#409eff; font-weight:500; }
.user-cell .phone { color:#f56c6c; }
>>> .el-table th { background:#f0f4ff !important; }
>>> .el-table--striped .el-table__body tr.el-table__row--striped td { background:#fafbff; }
>>> .el-table tbody tr:hover > td { background:#eef2ff !important; }
>>> .el-table__body-wrapper::-webkit-scrollbar { width:6px; height:6px; }
>>> .el-table__body-wrapper::-webkit-scrollbar-track { border-radius:10px; background-color:#f0f0f0; }
>>> .el-table__body-wrapper::-webkit-scrollbar-thumb { border-radius:10px; background-color:#c0c4cc; }
</style>
