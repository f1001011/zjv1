<template>
  <div class='page-content'>
    <el-row :gutter="20">
      <el-col :xs="24" :sm="12" :lg="4">
        <el-input placeholder="用户名称" v-model="searchParameter.user_name"></el-input>
      </el-col>
      <el-col :xs="24" :sm="12" :lg="4">
        <el-input placeholder="用户ID" v-model="searchParameter.uid"></el-input>
      </el-col>
      <el-col :xs="24" :sm="12" :lg="4">
            <el-select v-model="searchParameter.status" style="width:100%" placeholder="状态选择">
                <el-option key="1" label="查询余额" value="1"></el-option>
                <el-option key="2" label="积分" value="2"></el-option>
                <el-option key="3" label="绿币" value="3"></el-option>
                <el-option key="4" label="个人获得的返佣" value="4"></el-option>
                <el-option key="5" label="可提现金额" value="5"></el-option>
                <!-- <el-option key="6" label="团队佣金" value="6"></el-option> -->
                <el-option key="7" label="用户股权" value="7"></el-option>
                <el-option key="8" label="碳票" value="8"></el-option>
                <el-option key="9" label="公益捐款" value="9"></el-option>
            </el-select>
        </el-col>
    </el-row>
    <el-row>
      <el-col :xs="24" :sm="12" :lg="4" class="el-col2" style="margin-top: 10px;">
        <el-button @click="search">搜索</el-button>
      </el-col>
    </el-row>

    <el-table height="80vh" border style="margin-top: 15px" :data="roleList" :showPage="false">

      <el-table-column label="ID" prop="id"/>
      <el-table-column label="用户ID" prop="uid"/>
      <el-table-column label="用户名称" prop="user_name"/>
      <el-table-column label="开始金额" prop="money_before"/>
      <el-table-column label="金额" prop="money"/>
      <el-table-column label="结算金额" prop="money_end"/>
      <el-table-column label="是否有差异" prop="difference" >
         <template slot-scope="scope">
             <div style="color: red;" v-if="scope.row.difference != 0">{{scope.row.difference}}</div>
             <div style="color: blue;" v-if="scope.row.difference == 0">{{scope.row.difference}}</div>
         </template>
      </el-table-column>
      <el-table-column label="类型" prop="status"/>
      <el-table-column label="备注" prop="mark"/>
      <el-table-column label="时间" prop="create_time"/>

    </el-table>

    <el-dialog :title="dialogTitle" width="500px" :visible.sync="dvEdit">
      <el-form ref="form" :model="form" label-width="60px">
        <el-form-item label="用户名">
          <el-input v-model="form.username"></el-input>
        </el-form-item>
        <el-form-item label="描述：" prop="desc">
          <el-input
            type="textarea"
            :rows="3"
            v-model="form.desc"
          />
        </el-form-item>
        <el-form-item label="权限：">
          <el-tree
            :props="props"
            :load="loadNode"
            lazy
            show-checkbox
            @check-change="handleCheckChange">
          </el-tree>
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="dvEdit = false">取 消</el-button>
        <el-button type="primary" @click="onSubmit">确 定</el-button>
      </span>
    </el-dialog>
    <template v-if="allpage>20">
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
  import {getExamineData} from '@/api/MoneylogApi'
  export default {
    data () {
      return {
        searchParameter: {
          user_name: undefined,
          status: undefined,
        },
        allpage:1,//总页数
        showItem:5,//分页显示得中间按钮个数
        current:1,//当前页
        pageSize: 20,
        dvEdit: false,
        dialogTitle: '',
        form: {
          username: '',
          desc: '',
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
      handleCurrentChange:function(index){
                this.current = index;
                getExamineData({
                  page:index,
                  limit: this.pageSize,
                  'type':this.searchParameter.status,'user_name':this.searchParameter.user_name,'uid':this.searchParameter.uid
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
        getExamineData({'type':this.searchParameter.status,'user_name':this.searchParameter.user_name,'uid':this.searchParameter.uid,limit:this.pageSize}).then(res => {
          this.roleList = res.data.data
           this.allpage = res.data.total;
          console.log(res.data)
        })

      },
      showDialog(type) {
        this.dvEdit = true
        this.dialogTitle = type === 'add' ? '新增' : '编辑'
      },
      onSubmit() {
        this.dvEdit = false
      },
      search() {
        this.getUserList()
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
                  this.getUserList()
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
