<template>
    <div class='page-content'>
        <el-row :gutter="20">
            <el-col :xs="24" :sm="12" :lg="4">
              <el-select v-model="form_goods_id" style="width:100%" placeholder="请选择">
                  <el-option :key="index" :label="item.goods_name" :value="item.id" v-for="(item,index) in dataGoodsList"></el-option>
              </el-select>
            </el-col>
        </el-row>
        <el-row>
          <el-col :xs="24" :sm="12" :lg="4" class="el-col2" style="margin-top: 10px;">
            <el-button @click="search">搜索</el-button>
            <el-button @click="handleShowDialog('add',{})">新增天数</el-button>
          </el-col>
        </el-row>
        <div>
            <el-table height="500px" border style="margin-top: 15px" :data="dataList" :showPage="false">
                <el-table-column label="ID" prop="id" width="50"/>
                <el-table-column label="产品名称" prop="goods_name" width="" />
                <el-table-column label="起投价格" prop="goods_money" width="" />
                <el-table-column label="产品对应天数" prop="project_day" width="" />
                <el-table-column label="产品每日收益" prop="income" width="" />
                <el-table-column label="产品总收益" prop="total_red_money" width="" />
                <el-table-column label="到时间释放金额" prop="withdrawable_money" width="" />
                <el-table-column label="创建时间" prop="create_time" width="" />
                <!-- <el-table-column label="是否可购买" prop="is_enable" width="">
                    <template slot-scope="scope">
                        <div>{{scope.row.is_enable==1?'可购买':'不可购买'}}</div>
                    </template>
                </el-table-column> -->
                <el-table-column fixed="right" label="操作" width="150px">
                    <template slot-scope="scope">
                    <el-button type="text" icon="el-icon-edit" @click="handleShowDialog('edit',scope.row)">
                        编辑
                    </el-button>
                    <el-button type="text" style="color: #FA6962" icon="el-icon-delete" @click="productLevelDel(scope.row)">
                        删除
                    </el-button>
                    </template>
                </el-table-column>
            </el-table>
        </div>
        <div>
            <template v-if="allpage>10">
                <el-pagination @current-change="handleCurrentChange"
                        :current-page="current"
                        :page-size="10"
                        layout="total, prev, pager, next, jumper"
                        :total="allpage">
                </el-pagination>
            </template>
        </div>


        <el-dialog :title="dialogTitle" width="500px" :visible.sync="showDialog">
            <el-form ref="form" :model="form" label-width="130px">
                <el-form-item label="产品名称">
                    <el-select v-model="form.goods_id" style="width:100%" placeholder="请选择">
                        <el-option :key="index" :label="item.goods_name+'(起投价:'+item.goods_money+')'" :value="item.id" v-for="(item,index) in dataGoodsList"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="产品对应天数">
                  <el-input v-model="form.project_day"></el-input>
                </el-form-item>
                <el-form-item label="产品每日收益">
                  <el-input v-model="form.income"></el-input>
                </el-form-item>
                <el-form-item label="产品总收益">
                  <el-input v-model="form.total_red_money"></el-input>
                </el-form-item>
                <el-form-item label="到期释放金额">
                  <el-input v-model="form.withdrawable_money"></el-input>
                </el-form-item>
                <!-- <el-form-item label="是否可购买">
                    <el-radio-group v-model="form.is_enable" size="medium">
                        <el-radio :key="1" :label="1">可购买</el-radio>
                        <el-radio :key="0" :label="0">不可购买</el-radio>
                    </el-radio-group>
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
    import {getProductLevelListApi,productLevelEditApi,productLevelAddApi,productLevelDelApi,productSelApi} from '@/api/Product'
    import {baseUrl} from "@/utils/config.js";
    import axios from "axios"
  export default {
        data() {
            return {
                dialogTitle:'产品分类',
                form_goods_id:'',
                dataList: [],
                dataGoodsList: [],
                allpage: 1, //总页数
                showItem: 5, //分页显示得中间按钮个数
                current: 1, //当前页
                showDialog: false,
                form: {},
                uploadImage: baseUrl + '/upload/video',
                imageList: [],
            };
        },
        created() {
            this.getProductList()
            this.getProductGoodsList()
        },
        mounted() {
        },
        methods: {
            /**
             *  获取产品列表
            */
            getProductList() {
                let data = {
                    page: this.current,
                    limit: 10,
                    goods_id:this.form_goods_id
                }
                getProductLevelListApi(data).then(res => {
                    this.allpage = res.data.total;
                    this.dataList = res.data.data
                })
            },
            search:function(){
              this.handleCurrentChange(1);
            },
            getProductGoodsList() {
                productSelApi().then(res => {
                    this.dataGoodsList = res.data
                })
            },
            productLevelDel(scope) {
                this.$confirm('您确定要删除当前产品吗？', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'error'
                }).then(() => {
                productLevelDelApi({
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
            productLevelEdit() {
                productLevelEditApi(this.form).then(res => {
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
            productLevelAdd() {
                productLevelAddApi(this.form).then(res => {
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
                if(this.editProductType == 'edit') {
                    this.form = {
                        ...rowData
                    }
                    console.log("this.form :",this.form )
                    return
                }
                if(this.editProductType == 'add') {
                    this.form = {
                    }
                }
            },
            handleCurrentChange(index){
                this.current = index;
                this.getProductList()
            },
            onSubmit() {
                if(this.editProductType == 'edit') {
                    this.productLevelEdit()
                    return
                }
                if(this.editProductType == 'add') {
                    this.productLevelAdd()
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
                this.form.pic_path = res.data.data[0]
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
