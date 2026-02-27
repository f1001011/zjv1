<template>
    <div class='page-content'>
        <el-row :gutter="20">
            <el-col :xs="24" :sm="12" :lg="4" class="el-col2">
                <el-button @click="handleShowDialog('add',{})">新增</el-button>
            </el-col>
        </el-row>
        <div>
            <el-table border style="margin-top: 15px" :data="dataList" :showPage="false">
                <el-table-column label="主键ID" prop="id" width="80"/>
                <el-table-column label="客服地址" prop="url" width="200" />
                 <el-table-column label="电话" prop="phone" width="200"/>
                <el-table-column label="备注" prop="remarks" width="200"/>


                <el-table-column fixed="right" label="操作" width="150px">
                    <template slot-scope="scope">
                    <el-button type="text" icon="el-icon-edit" @click="handleShowDialog('edit',scope.row)">
                        编辑
                    </el-button>
                    <el-button type="text" style="color: #FA6962" icon="el-icon-delete" @click="customDel(scope.row)">
                        删除
                    </el-button>
                    </template>
                </el-table-column>
            </el-table>
        </div>
        <div>
            <template v-if="allpage>10">
                <el-pagination @current-change="handleCurrentChange"
                        @size-change="handleSizeChange"
                        :current-page="current"
                        :page-sizes="[10, 20, 50, 100]"
                        :page-size="pageSize"
                        layout="sizes, total, prev, pager, next, jumper"
                        :total="allpage">
                </el-pagination>
            </template>
        </div>


        <el-dialog :title="dialogTitle" width="500px" :visible.sync="showDialog">
            <el-form ref="form" :model="form" label-width="130px">
                <!-- <el-form-item label="客服类型"> -->
                    <!-- <el-input v-model="form.type"></el-input> -->
                    <!-- <el-select v-model="form.type" style="width:100%" placeholder="请选择">
                        <el-option :key="index" :label="item.name" :value="item.id" v-for="(item,index) in typeList"></el-option>
                    </el-select>
                </el-form-item> -->
                <el-form-item label="链接地址">
                    <el-input v-model="form.url"></el-input>
                </el-form-item>
                <!-- <el-form-item label="名字">
                    <el-input v-model="form.username"></el-input>
                </el-form-item> -->
                <el-form-item label="电话">
                    <el-input v-model="form.phone"></el-input>
                </el-form-item>
               <!-- <el-form-item label="业务员ID" prop="market_uid"
                    :rules="[
                    { required: true, message: '业务员ID不能为空'},
                    { type: 'number', message: '业务员ID必须为数字值'}
                    ]">
                        <el-input v-model.number="form.market_uid" placeholder="请输入业务员ID" :disabled="myInfo.role === 2"></el-input>
                </el-form-item> -->
            </el-form>

            <span slot="footer" class="dialog-footer">
                <el-button @click="showDialog = false">取 消</el-button>
                <el-button type="primary" @click="onSubmit()">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
    import {getCustomListApi,customEditApi,customAddApi,customDelApi} from '@/api/CustomApi'

    import {baseUrl} from "@/utils/config.js";
    import axios from "axios"
  export default {
        data() {
            return {
                dialogTitle:'客服',
                dataList: [],
                allpage: 1, //总页数
                showItem: 5, //分页显示得中间按钮个数
                current: 1, //当前页
                pageSize: 10,
                showDialog: false,
                form: {
                  market_uid: null
                },
                uploadImage: baseUrl + '/upload/video',
                imageList: [],
                typeList: [{
                    id: '1',
                    name: '飞鸽'
                },{
                    id: '2',
                    name: '推特'
                }],
              myInfo: {}
            };
        },
        created() {
            this.getCustomList()
        },
        mounted() {
          this.myInfo = JSON.parse(localStorage.getItem('myInfo'))
        },
        methods: {
            /**
             *  获取轮播列表
            */
            getCustomList() {
                let data = {
                    page: this.current,
                    limit: this.pageSize
                }
                getCustomListApi(data).then(res => {
                    this.allpage = res.data.total;
                    this.dataList = res.data.data
                })
            },

            customDel(scope) {
                this.$confirm('您确定要删除当前轮播吗？', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'error'
                }).then(() => {
                customDelApi({
                    'id': scope.id
                }).then(res => {
                    if (res.code == 1) {
                        this.$message({
                            message: '删除成功',
                            type: 'success'
                        });
                        this.getCustomList();
                        return;
                    }
                })
                }).catch(() => {})
            },
            /**
             *  获取轮播列表
            */
            customEdit() {
                customEditApi(this.form).then(res => {
                    if(res.code == 1){
                        this.$message({message:res.msg,type: 'success'});
                        this.showDialog = false
                        this.getCustomList()
                        return;
                    }

                })
            },
            /**
             *  获取轮播列表
            */
            customAdd() {
                customAddApi(this.form).then(res => {
                    if(res.code == 1){
                        this.$message({message:res.msg,type: 'success'});
                        this.showDialog = false
                        this.getCustomList()
                        return;
                    }

                })
            },

            /**
             * 展示对话框
            */
            handleShowDialog(type,rowData) {
                this.editCustomType = type
                this.showDialog = true
                if(this.editCustomType == 'edit') {
                    this.form = {
                        ...rowData
                    }
                    return
                }
                if(this.editCustomType == 'add') {
                    this.form = {
                    }
                    if (this.myInfo.role === 2) {
                      this.form.market_uid = this.myInfo.id
                    }
                }
            },
            handleCurrentChange(index){
                this.current = index;
                this.getCustomList()
            },
            handleSizeChange(val) {
                this.pageSize = val;
                this.current = 1;
                this.getCustomList();
            },
            onSubmit() {
                if(this.editCustomType == 'edit') {
                    this.customEdit()
                    return
                }
                if(this.editCustomType == 'add') {
                    this.customAdd()
                }
            },
            handleAvatarError: function(error, file) {
                window.wxc.xcConfirm(error, window.wxc.xcConfirm.typeEnum.error);
            },
            handleRemove: function(file, fileList) {
                this.imageList = fileList;
            },
            uploadFile: function(file) {
                var fm = new FormData();
                fm.append('file', file.file);
                axios.post('/upload/video', fm).then(res => {

                var arr = {
                    'url': res.data.data[0],
                    'uid': file.file.uid,
                };
                // console.log(res.data.data)
                    this.form.img = res.data.data[0]
                    this.imageList.push(arr);
                });
            },
        },
  }
</script>

<style lang='scss' scoped>
    .page-content {
        width: 100%;
        height: 100%;
    }
</style>
