<template>
  <div class='page-content'>
    <el-row :gutter="20">
     <!-- <el-col :xs="24" :sm="12" :lg="4">
        <el-input placeholder="分类名"></el-input>
      </el-col> -->
      <el-col :xs="24" :sm="12" :lg="4" class="el-col2">
        <!-- <el-button>搜索</el-button> -->
        <el-button @click="showDialog('add','')">新增</el-button>
      </el-col>
    </el-row>

    <el-table height="80vh" border style="margin-top: 15px" :data="roleList" :showPage="false">
      <el-table-column label="ID" prop="id"/>
      <el-table-column label="标题" prop="title"/>
      <el-table-column label="邀请会员数量" prop="number"/>
      <el-table-column label="邀请会员达标奖励" prop="reward"/>
      <el-table-column label="是否启用" prop="status">
        <template slot-scope="scope">
          <el-tag size="mini" :type="scope.row.status ? '' : 'info'">
            {{scope.row.status == 1 ? '启用' : '禁用'}}
          </el-tag>
          <el-switch   v-model="scope.row.status" @change="changes(scope.row.status,scope.row)" :active-value="1" :inactive-value="0"></el-switch>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" prop="create_time"/>
      <el-table-column fixed="right" label="操作" width="150px">
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

    <el-dialog :title="dialogTitle" width="500px" :visible.sync="dvEdit">
      <el-form ref="form" :model="form" label-width="125px">
        <el-form-item label="标题">
          <el-input v-model="form.title"></el-input>
        </el-form-item>
        <el-form-item label="邀请会员数量">
          <el-input type="number" v-model="form.number" :min='0'></el-input>
        </el-form-item>
        <el-form-item label="邀请会员达标奖励">
          <el-input type="number" v-model="form.reward" :min='0'></el-input>
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
  import {getInvitationListApi,getInvitationAddApi,getInvitationEditApi,getInvitationStatusApi} from '@/api/ArticleTypeApi'
  export default {
    data () {
      return {
        allpage:1,//总页数
        showItem:5,//分页显示得中间按钮个数
        current:1,//当前页
        pageSize: 10,
        dvEdit: false,
        dialogTitle: '',
        form: {
          id: 0,
          title: '',
          number: 0,
          reward: 0,
          status: 0,
        },
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
          getInvitationStatusApi({
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
                getInvitationListApi({
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
        getInvitationListApi({limit: this.pageSize}).then(res => {
          this.roleList = res.data.data
           this.allpage = res.data.total;
        })
      },

      showDialog(type,row) {
        this.dvEdit = true;
        if(type === 'edit') this.form  = row;
        if(type === 'add') this.form  = {};
        this.dialogTitle = type === 'add' ? '新增' : '编辑'
      },

      onSubmit() {
        if(this.form.number < 0){
          this.$message({message:'邀请会员数量错误',type: 'error'});
          return
        }
        if(this.form.reward < 0){
          this.$message({message:'邀请会员达标奖励错误',type: 'error'});
          return
        }
        if(this.form.id){
          getInvitationEditApi(this.form).then(res => {

          if(res.code == 1){
           this.dvEdit = false
           this.$message({message:res.msg,type: 'success'});
           this.handleCurrentChange(this.current);
            return;
          }
          })
          return;
        }
         getInvitationAddApi(this.form).then(res => {
        if(res.code == 1){
           this.dvEdit = false
           this.$message({message:res.msg,type: 'success'});
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
          getArticleTypeDelApi({'id':scope.id}).then(res=>{
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
</style>
