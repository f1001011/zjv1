<template>
  <div class='page-content'>
    <div class="toolbar">
      <div class="toolbar-title">资金流动日志</div>
    </div>
    <div class="search-wrap">
      <el-row :gutter="12">
        <el-col :xs="24" :sm="12" :lg="4">
          <el-input size="small" placeholder="用户" prefix-icon="el-icon-user" v-model="user_name" clearable></el-input>
        </el-col>
        <el-col :xs="24" :sm="12" :lg="4">
          <el-input size="small" placeholder="用户ID" prefix-icon="el-icon-search" v-model="uid" clearable></el-input>
        </el-col>
        <el-col :xs="24" :sm="12" :lg="4">
          <el-select size="small" v-model="type" style="width:100%" placeholder="类型筛选" clearable>
            <el-option key="" label="全部" value=""></el-option>
            <el-option key="1" label="收入" :value="1"></el-option>
            <el-option key="2" label="支出" :value="2"></el-option>
            <el-option key="3" label="官方操作" :value="3"></el-option>
          </el-select>
        </el-col>
        <el-col :xs="24" :sm="12" :lg="4" style="margin-top:0">
          <el-button size="small" type="primary" icon="el-icon-search" @click="search">搜索</el-button>
        </el-col>
      </el-row>
    </div>
    <div class="table-wrap">
      <el-table height="calc(80vh - 130px)" style="width:100%" stripe :data="roleList"
        :header-cell-style="headerCellStyle" :cell-style="cellStyle" @sort-change="sortChange">
        <el-table-column label="ID" width="70" prop="id" align="center"/>
        <el-table-column width="130" label="用户信息" prop="user_name">
          <template slot-scope="scope">
            <div class="user-cell">
              <span class="uid">ID: {{scope.row.uid}}</span>
              <span class="uname">{{scope.row.user_name}}</span>
              <span class="phone">{{scope.row.phone}}</span>
            </div>
          </template>
        </el-table-column>
        <el-table-column label="变化前" width="100" prop="money_before" align="right"/>
        <el-table-column label="变化金额" width="100" prop="money" align="right">
          <template slot-scope="scope">
            <span :style="{color: scope.row.type==2?'#f56c6c':'#67c23a', fontWeight:'600'}">{{scope.row.money}}</span>
          </template>
        </el-table-column>
        <el-table-column label="变化后" width="100" prop="money_end" align="right"/>
        <el-table-column label="操作时间" sortable="custom" width="160" prop="create_time" align="center"/>
        <el-table-column label="详细类型" width="150" prop="status"/>
        <el-table-column label="类型" width="100" prop="type" align="center">
          <template slot-scope="scope">
            <el-tag :type="scope.row.type==1?'success':(scope.row.type==2?'danger':'warning')" size="mini" effect="plain">
              {{scope.row.type==1?'收入':(scope.row.type==2?'支出':'官方操作')}}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="备注" prop="mark"/>
      </el-table>
    </div>
    <div class="pagination-wrap">
      <el-pagination @current-change="handleCurrentChange" @size-change="handleSizeChange"
        :current-page="current" :page-sizes="[10, 20, 50, 100]" :page-size="pageSize"
        layout="sizes, total, prev, pager, next, jumper" :total="allpage">
      </el-pagination>
    </div>
  </div>
</template>

<script>
   import {getMoneyListApi} from '@/api/MoneylogApi'
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
          username: '',
          desc: '',
        },
        detailType: [
        {
            id: "",
            label: '全部'
        },{
            id: "101",
            label: '充值'
        },{
            id: "102",
            label: '注册'
        },
        {
            id: "103",
            label: '签到'
        },
        {
            id: "104",
            label: '邀请注册奖励'
        },{
            id: "106",
            label: '佣金收入'
        },
        {
            id: "107",
            label: '产品收入'
        },
        {
            id: "108",
            label: '产品推广奖励'
        },
        {
            id: "109",
            label: '资产转入'
        },
        {
            id: "201",
            label: '提现'
        },
        {
            id: "204",
            label: '资产转出'
        },
        {
            id: "205",
            label: '产品购买抵扣'
        }],
        props: {
          label: 'name',
          children: 'zones'
        },
        count: 1,
        roleList: [],
        user_name:'',
        uid:'',
        create_time_sort:'',
        currencyType: '',
        status: '',
        type: ''
      };
    },
    mounted() {
      this.getUserList()
      //console.log(this.getVideoBase64('http://tp.com/static/qwe.mp4'))
    },
    methods: {
      getVideoBase64(url) {
            return new Promise(function (resolve, reject) {
                let dataURL = '';
                let video = document.createElement("video");
                video.setAttribute('crossOrigin', 'anonymous');//处理跨域
                video.setAttribute('src', url);
                video.setAttribute('width', 400);
                video.setAttribute('height', 240);
                video.addEventListener('loadeddata', function () {
                    let canvas = document.createElement("canvas"),
                        width = video.width, //canvas的尺寸和图片一样
                        height = video.height;
                    canvas.width = width;
                    canvas.height = height;
                    canvas.getContext("2d").drawImage(video, 0, 0, width, height); //绘制canvas
                    dataURL = canvas.toDataURL('image/jpeg'); //转换为base64

                    resolve(dataURL);
                });
            })
        },
      toSource:function(row){
        if(row.source_id){
          if(row.status == '充值分销奖励'){
            this.$router.push({path: '/platform/rechargelog', query: {id: row.source_id}})
            return;
            }
                 // this.$router.push('/log/order?id='+row.source_id)
            this.$router.push({path: '/platform/order', query: {id: row.source_id}})
            }
      },
      sortChange:function(column, prop, order){

        if(column.order == 'ascending'){
          this.create_time_sort = 'asc';
        }else{
          this.create_time_sort = 'desc';
        }
        this.handleCurrentChange(1);
      },
      search:function(){
        this.handleCurrentChange(1);
      },
      handleCurrentChange:function(index){
        this.current = index;
        getMoneyListApi({
          page:index,
          limit: this.pageSize,
          user_name:this.user_name,
          uid:this.uid,
          create_time_sort:this.create_time_sort,'class':this.currencyType,status:this.status,type:this.type
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
      getMoneyListApi:function(index){
                this.current = index;
                getArticleTypeListApi({
                  page:index,
                 'class':this.currencyType,status:this.status,type:this.type
                }).then(res => {
                  this.roleList = res.data.data;
                  this.allpage = res.data.total;
                })
      },
      getUserList(){
        getMoneyListApi({uid:this.uid,create_time_sort:this.create_time_sort,'class':this.currencyType,status:this.status,type:this.type,limit:this.pageSize}).then(res => {
          this.roleList = res.data.data
           this.allpage = res.data.total;
          console.log(res.data)
        })

      },
      showDialog(type) {
        this.dvEdit = true
        this.dialogTitle = type === 'add' ? '新增角' : '编辑'
      },
      onSubmit() {
        this.dvEdit = false
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
                  this.getUserList()
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
