<template>
  <div class='page-content'>

    <el-table style="margin-top: 15px;" border :data="roleList" :showPage="false">
      <el-table-column label="ID" width="80" prop="id" />
      <el-table-column label="开户人姓名" width="120" prop="account_name" />
      <el-table-column label="银行名称" width="120" prop="name" />
      <el-table-column label="银行卡号" width="120" prop="card" />
      <el-table-column label="状态" width="120" prop="status">
        <template slot-scope="scope">
            <el-tag size="mini">
              {{scope.row.status == 1 ? '正常' : '删除'}}
            </el-tag>
        </template>
      </el-table-column>
      <el-table-column width="180" label="是否默认使用" prop="is_default">
        <template slot-scope="scope">
          <el-tag size="mini">
            {{scope.row.is_default == 1 ? '是' : '否'}}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="70px">
        <template slot-scope="scope">
          <el-button type="text" icon="el-icon-edit" @click="showDialog('edit',scope.row)">
            编辑
          </el-button>
          <!-- <el-button type="text" style="color: #FA6962" icon="el-icon-delete" @click="deleteUser(scope.row)">
            删除
          </el-button> -->
        </template>
      </el-table-column>
    </el-table>

    <el-dialog :title="dialogMoneyTitle" width="500px" :visible.sync="dvEdit">
      <el-form ref="form" :model="moneyForm" label-width="70px">
        <el-form-item label="银行名">
          <el-input v-model="form.name" placeholder="请输入银行名称"></el-input>
        </el-form-item>
        <el-form-item label="银行卡号">
          <el-input v-model="form.card" placeholder="请输入银行卡号"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dvEdit = false">取 消</el-button>
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

  import {getBankCard,getBankCardEdit} from '@/api/userApi'
  export default {
    data() {
      return {
        allpage: 1, //总页数
        showItem: 5, //分页显示得中间按钮个数
        current: 1, //当前页
        pageSize: 10,
        dvEdit: false,
        dialogTitle: '',
        form: {},
        count: 1,
        roleList: [],
        uid:'',
        dialogMoneyTitle:'编辑银行卡信息',
        moneyForm:{},
      };
    },
    watch:{
      '$route' (to, from) {
        if(to.path=='/user/bankCard'){
            this.getUserList();
        }
       }
    },
    mounted() {
      this.getUserList();
    },
    methods: {
      onMoneySubmit:function(){
        //这里要修改方法
        getBankCardEdit({
          id: this.form.id,
          name:this.form.name,
          card:this.form.card,
        }).then(res => {
          if(res.code === 1){
            this.$message({
              message:'操作成功',
              type: 'success'
             });
             this.dvEdit = false;
             this.form = {};
             this.getUserList()
          }
        })
      },
      handleCurrentChange: function(index) {
        this.current = index;
        getBankCard({
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
        getBankCard({uid:this.$route.query.uid, limit: this.pageSize}).then(res => {
          this.roleList = res.data.data
          this.allpage = res.data.total;
        })
      },
      showDialog(type, row) {
        this.dvEdit = true;
        this.form = row;
      },
      onSubmit() {
        if (this.form.id) {
          getUserEditApi(this.form).then(res => {
            if(res.code == 1){
               this.dvEdit = false
               this.$message({message: '编辑成功',type: 'success'});
               this.getUserList();
               this.handleCurrentChange(this.current);
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
