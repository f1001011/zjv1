<template>
    <div class='page-content'>
        <el-row :gutter="20">
            <el-col :xs="24" :sm="12" :lg="4" class="el-col2">
                <el-button @click="handleShowDialog('add',{})">新增</el-button>
            </el-col>
        </el-row>
        <div>
            <el-table  height="80vh" border :data="dataList" :showPage="false">
                <el-table-column label="主键ID" prop="id" width="80"/>
                <el-table-column label="添加时间" prop="add_time" width="200" />
                <el-table-column label="是否显示" prop="status" width="">
                    <template slot-scope="scope">
                        <div>{{scope.row.status==0?'否':'是'}}</div>
                    </template>
                </el-table-column>
                <el-table-column label="图片地址" prop="img" width="200"/>
                <el-table-column label="排序" prop="sort" />
                <el-table-column label="类型" prop="is_type" width="">
                    <template slot-scope="scope">
                        <div>{{scope.row.is_type==0?'图片':'文章'}}</div>
                    </template>
                </el-table-column>
                <el-table-column label="显示位置" prop="type" width="">
                    <template slot-scope="scope">
                        <div>{{scope.row.type==1?'轮播图':scope.row.type== 5?'弹出公告图':''}}</div>
                    </template>
                </el-table-column>

                <el-table-column fixed="right" label="操作" width="150px">
                    <template slot-scope="scope">
                    <el-button type="text" icon="el-icon-edit" @click="handleShowDialog('edit',scope.row)">
                        编辑
                    </el-button>
                    <el-button type="text" style="color: #FA6962" icon="el-icon-delete" @click="adsDel(scope.row)">
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


        <el-dialog :title="dialogTitle" width="700px" :visible.sync="showDialog">
            <el-form ref="form" :model="form" label-width="80px">
                <el-form-item label="排序">
                    <el-input v-model="form.sort"></el-input>
                </el-form-item>
                <el-form-item label="显示位置">
                <el-select v-model="form.type" style="width:100%" placeholder="状态选择">
                    <el-option key="1" label="轮播图" value="1"></el-option>
                    <el-option key="5" label="弹出层图" value="5"></el-option>

                </el-select>
                </el-form-item>
                <el-form-item label="轮播图片" v-if="form.is_type == 0">
                    <el-upload enctype="multipart/form-data" class="upload-demo" :action="uploadImage"
                        accept=".jpg,.png,.mp4,.avi" name="file" :limit="1" :on-error="handleAvatarError"
                        :on-remove="handleRemove" :file-list="imageList" :http-request="uploadFile" list-type="picture">
                        <el-button size="small" type="primary">上传图片</el-button>
                        <div slot="tip" class="el-upload__tip"></div>
                    </el-upload>
                </el-form-item>
                <el-form-item label="文章内容" v-else>
                    <quill-editor class="editor" ref="quillEditor" v-model="form.content" :options="editorOption"/>
                </el-form-item>
                <el-form-item label="是否显示">
                    <el-radio-group v-model="form.status">
                        <el-radio :label="1">是</el-radio>
                        <el-radio :label="0">否</el-radio>
                    </el-radio-group>
                </el-form-item>
                <el-form-item label="类型">
                    <el-radio-group v-model="form.is_type">
                        <el-radio :label="0">图片</el-radio>
                        <el-radio :label="1">文章</el-radio>
                    </el-radio-group>
                </el-form-item>
            </el-form>

        <span slot="footer" class="dialog-footer">
            <el-button @click="showDialog = false">取 消</el-button>
            <el-button type="primary" @click="onSubmit()">确 定</el-button>
        </span>
        </el-dialog>
    </div>
</template>

<script>
    import {getAdsListApi,adsEditApi,adsAddApi,adsDelApi} from '@/api/AdsApi'
    import quillConfig from "@/utils/quill-config.js";
    import {baseUrl} from "@/utils/config.js";
    import axios from "axios"
  export default {
        data() {
            return {
                dialogTitle:'轮播',
                dataList: [],
                allpage: 1, //总页数
                showItem: 5, //分页显示得中间按钮个数
                current: 1, //当前页
                pageSize: 10,
                showDialog: false,
                form: {},
                uploadImage: baseUrl + '/upload/video',
                imageList: [],
                editorOption: quillConfig,
            };
        },
        created() {
            this.getAdsList()
        },
        mounted() {
        },
        methods: {
            /**
             *  获取轮播列表
            */
            getAdsList() {
                let data = {
                    page: this.current,
                    limit: this.pageSize
                }
                getAdsListApi(data).then(res => {
                    this.allpage = res.data.total;
                    this.dataList = res.data.data
                })
            },

            adsDel(scope) {
                this.$confirm('您确定要删除当前轮播吗？', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'error'
                }).then(() => {
                adsDelApi({
                    'id': scope.id
                }).then(res => {
                    if (res.code == 1) {
                        this.$message({
                            message: '删除成功',
                            type: 'success'
                        });
                        this.getAdsList();
                        return;
                    }
                })
                }).catch(() => {})
            },
            /**
             *  获取轮播列表
            */
            adsEdit() {
                adsEditApi(this.form).then(res => {
                    if(res.code == 1){
                        this.$message({message:res.msg,type: 'success'});
                        this.showDialog = false
                        this.getAdsList()
                        return;
                    }

                })
            },
            /**
             *  获取轮播列表
            */
            adsAdd() {
                adsAddApi(this.form).then(res => {
                    if(res.code == 1){
                        this.$message({message:res.msg,type: 'success'});
                        this.showDialog = false
                        this.getAdsList()
                        return;
                    }

                })
            },

            /**
             * 展示对话框
            */
            handleShowDialog(type,rowData) {
                this.editAdsType = type
                this.showDialog = true
                if(this.editAdsType == 'edit') {
                    this.form = {
                        ...rowData
                    }
                    return
                }
                if(this.editAdsType == 'add') {
                    this.form = {
                    }
                }
            },
            handleCurrentChange(index){
                this.current = index;
                this.getAdsList()
            },
            handleSizeChange(val) {
                this.pageSize = val;
                this.current = 1;
                this.getAdsList();
            },
            onSubmit() {
                if(this.editAdsType == 'edit') {
                    this.adsEdit()
                    return
                }
                if(this.editAdsType == 'add') {
                    this.adsAdd()
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
                this.form.img = res.data.data[1]
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
    >>> .ql-container {
        height: 400px;
      }
</style>
