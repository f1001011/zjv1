<template>
    <div class='page-content'>
        <el-row :gutter="20">

            <el-col :xs="24" :sm="12" :lg="4" class="el-col2">
                <el-button @click="handleShowDialog('add',{})">新增产品</el-button>
            </el-col>
        </el-row>
        <div>
            <el-table height="80vh" border  :data="dataList" :showPage="false">
              <el-table-column label="ID" prop="id" width="80"/>
                <el-table-column label="分类名称" prop="goods_type_name" width="100"/>
                <el-table-column label="产品名称" prop="goods_name" width="100" />
                <el-table-column label="起投金额" prop="goods_money" width="100"/>
                <el-table-column label="每日分红( 展示)" prop="day_red" />
                <el-table-column label="投资周期(展示天)" prop="period" width="100"/>
                <el-table-column label="商品属性" prop="goods_day_red" width="400">
                <template slot-scope="scope">
                    <div v-html='scope.row.goods_day_red'></div>
                </template>
                </el-table-column>
                <el-table-column label="项目规模" prop="project_scale" width="100"/>
                <el-table-column label="投资进度" prop="progress_rate" width="100"/>
                <el-table-column label="VIP等级" prop="level_vip" width="80"/>
                <el-table-column label="购买次数限制" prop="buy_num" width="100"/>
                <el-table-column label="一级返佣(元)" prop="goods_agent_1" width="50"/>
                <el-table-column label="二级返佣(元)" prop="goods_agent_2" width="50"/>
                <el-table-column label="三级返佣(元)" prop="goods_agent_3" width="50"/>
                <el-table-column label="是否启用" prop="status" width="">
                    <template slot-scope="scope">
                        <div>{{scope.row.status==0?'否':'是'}}</div>
                    </template>
                </el-table-column>
                <el-table-column label="新手体验" prop="is_examine" width="">
                    <template slot-scope="scope">
                        <div>{{scope.row.is_examine==0?'否':'是'}}</div>
                    </template>
                </el-table-column>

                <el-table-column label="是否可用优惠卷" prop="is_coupon" width="">
                    <template slot-scope="scope">
                        <div>{{scope.row.is_coupon==0?'否':'是'}}</div>
                    </template>
                </el-table-column>

                <el-table-column label="权重（数值越小排名越前）" prop="sort" width="80"/>
                <el-table-column label="类型" prop="red_way_text" width="120"/>
                <el-table-column label="担保公司" prop="warrant" width="120"/>

                <el-table-column label="添加时间" prop="create_time" width="120"/>

                <el-table-column fixed="right" label="操作" width="150px">
                    <template slot-scope="scope">
                    <el-button type="text" icon="el-icon-edit" @click="handleShowDialog('edit',scope.row)">
                        编辑
                    </el-button>
                    <el-button type="text" style="color: #FA6962" icon="el-icon-delete" @click="productDel(scope.row)">
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

                <el-form-item label="产品类别">
                    <el-select v-model="form.goods_type_id" style="width:100%" placeholder="请选择">
                        <el-option :key="index" :label="item.type_name" :value="item.id" v-for="(item,index) in dataClassList"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="产品名称">
                    <el-input v-model="form.goods_name"></el-input>
                </el-form-item>
                <el-form-item label="起投金额">
                    <el-input v-model="form.goods_money"></el-input>
                </el-form-item>

                <el-form-item label="项目规模(万元)">
                    <el-input v-model="form.project_scale"></el-input>
                </el-form-item>
                <el-form-item label="每日分红(展示)">
                    <el-input v-model="form.day_red"></el-input>
                </el-form-item>

                <el-form-item label="投资周期(展示)">
                    <el-input v-model="form.period"></el-input>
                </el-form-item>

                <el-form-item label="担保公司">
                    <el-input v-model="form.warrant"></el-input>
                </el-form-item>
                <el-form-item label="投资进度">
                    <el-input v-model="form.progress_rate"></el-input>
                </el-form-item>
                <el-form-item label="VIP等级">
                    <el-input v-model.number="form.level_vip" placeholder="0表示不限制"></el-input>
                </el-form-item>
                <el-form-item label="购买次数限制">
                    <el-input v-model.number="form.buy_num" placeholder="0表示不限制"></el-input>
                </el-form-item>

                <!-- <el-form-item label="一级返佣">
                    <el-input v-model="form.goods_agent_1"></el-input>
                </el-form-item>
                <el-form-item label="二级返佣">
                    <el-input v-model="form.goods_agent_2"></el-input>
                </el-form-item>
                <el-form-item label="三级返佣">
                    <el-input v-model="form.goods_agent_3"></el-input>
                </el-form-item> -->
             <el-form-item label="是否上架">
                 <el-radio-group v-model="form.status">
                     <el-radio :label="1">是</el-radio>
                     <el-radio :label="0">否</el-radio>
                 </el-radio-group>
             </el-form-item>


              <el-form-item label="新手体验">
                  <el-radio-group v-model="form.is_examine">
                      <el-radio :label="1">是</el-radio>
                      <el-radio :label="0">否</el-radio>
                  </el-radio-group>
              </el-form-item>

            <el-form-item label="是否可用优惠卷">
                <el-radio-group v-model="form.is_coupon">
                    <el-radio :label="1">是</el-radio>
                    <el-radio :label="0">否</el-radio>
                </el-radio-group>
            </el-form-item>


                <el-form-item label="产品图片">
                    <el-upload v-if="showDialog" enctype="multipart/form-data" class="upload-demo" :action="uploadImage"
                        accept=".jpg,.png,.mp4,.avi" name="file" :limit="1" :on-error="handleAvatarError"
                        :on-remove="handleRemove" :http-request="uploadFile" list-type="picture">
                        <el-button size="small" type="primary">封面点击上传</el-button>
                        <div slot="tip" class="el-upload__tip">
                            <img :src="form.head_img" alt="" style="width: 100px;height:auto">
                        </div>
                    </el-upload>
                </el-form-item>

                <el-form-item label="详情下图">
                    <el-upload v-if="showDialog" enctype="multipart/form-data" class="upload-demo" :action="uploadImage"
                        accept=".jpg,.png,.mp4,.avi" name="file" :limit="1" :on-error="handleAvatarError"
                        :on-remove="handleRemove1" :http-request="uploadFile1" list-type="picture">
                        <el-button size="small" type="primary">封面点击上传</el-button>
                        <div slot="tip" class="el-upload__tip">
                            <img :src="form.bottom_img" alt="" style="width: 100px;height:auto">
                        </div>
                    </el-upload>
                </el-form-item>

                <el-form-item label="排序" prop="sort">
                     <el-input v-model.number="form.sort" placeholder="数值越小排名越前"></el-input>
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
    import {getProductListApi,productEditApi,productAddApi,productDelApi,getProductClassListApi,getProductLevelListApi} from '@/api/Product'
    import {baseUrl} from "@/utils/config.js";
    import axios from "axios"
  export default {
        data() {
            return {
                dialogTitle:'产品',
                dataList: [],
                dataClassList: [],
                dataLevelList: [],
                allpage: 1, //总页数
                showItem: 5, //分页显示得中间按钮个数
                current: 1, //当前页
                pageSize: 10,
                showDialog: false,
                form: {},
                uploadImage: baseUrl + '/upload/video',
                imageList: [],
            };
        },
        created() {
            this.getProductList()
            this.getProductClassList()
            this.getProductLevelList()
        },
        mounted() {
        },
        methods: {
            /**
             *  获取产品列表
            */
            getProductLevelList() {
                let data = {
                    page: 1,
                    limit:99999
                }
                getProductLevelListApi(data).then(res => {
                    this.dataLevelList = res.data.data
                })
            },
            /**
             *  获取产品分类列表
            */
            getProductClassList() {
                let data = {
                    page: 1,
                    limit: 99999
                }
                getProductClassListApi(data).then(res => {
                    this.dataClassList = res.data.data
                })
            },
            /**
             *  获取产品列表
            */
            getProductList() {
                let data = {
                    page: this.current,
                    limit: this.pageSize
                }
                getProductListApi(data).then(res => {
                    this.allpage = res.data.total;
                    this.dataList = res.data.data
                })
            },

            productDel(scope) {
                this.$confirm('您确定要删除当前产品吗？', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'error'
                }).then(() => {
                productDelApi({
                    'id': scope.id
                }).then(res => {
                    if (res.code == 1) {
                        this.$message({
                            message: '删除成功',
                            type: 'success'
                        });
                        this.getProductList();
                        return;
                    }
                })
                }).catch(() => {})
            },
            /**
             *  获取产品列表
            */
            productEdit() {

                productEditApi(this.form).then(res => {
                    if(res.code == 1){
                        this.$message({message:res.msg,type: 'success'});
                        this.showDialog = false
                        this.getProductList()
                        return;
                    }

                })
            },
            /**
             *  获取产品列表
            */
            productAdd() {

                productAddApi(this.form).then(res => {
                    if(res.code == 1){
                        this.$message({message:res.msg,type: 'success'});
                        this.showDialog = false
                        this.getProductList()
                        return;
                    }

                })
            },

            /**
             * 展示对话框
            */
            handleShowDialog(type,rowData) {
                this.editProductType = type
                this.showDialog = true
                this.imageList = []
                if(this.editProductType == 'edit') {
                    // console.log("rowData:",rowData)
                    rowData.oldImgPath = rowData.pic_path
                    this.form = {
                        ...rowData
                    }
                    return
                }
                if(this.editProductType == 'add') {
                    this.form = {
                        is_open: 1
                    }

                }
            },
            handleCurrentChange(index){
                this.current = index;
                this.getProductList()
            },
            handleSizeChange(val) {
                this.pageSize = val;
                this.current = 1;
                this.getProductList();
            },
            onSubmit() {


                if(this.editProductType == 'edit') {

                    this.productEdit()
                    return
                }
                if(this.editProductType == 'add') {
                    this.productAdd()
                }
            },
            handleAvatarError: function(error, file) {
                window.wxc.xcConfirm(error, window.wxc.xcConfirm.typeEnum.error);
            },
            handleRemove: function(file, fileList) {
                // this.imageList = fileList;
                this.form.head_img = this.form.oldImgPath
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
                this.form.head_img = res.data.data[1][0]
                this.imageList.push(arr);
                });
            },
            handleRemove1: function(file, fileList) {
                // this.imageList = fileList;
                this.form.bottom_img = this.form.oldImgPath
            },
            uploadFile1: function(file) {
                var fm = new FormData();
                fm.append('file', file.file);
                axios.post('/upload/video', fm).then(res => {
                var arr = {
                    'url': res.data.data[0],
                    'uid': file.file.uid,
                };
                // console.log(res.data.data)
                this.form.bottom_img = res.data.data[1][0]
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
