<template>
    <div class='page-content'>
        <div class="toolbar">
            <div class="toolbar-title">产品列表</div>
            <el-button class="btn-add" type="primary" icon="el-icon-plus" @click="handleShowDialog('add',{})">新增产品</el-button>
        </div>
        <div class="table-wrap">
            <el-table
                height="calc(80vh - 100px)"
                :data="dataList"
                stripe
                :header-cell-style="headerCellStyle"
                :cell-style="cellStyle"
                style="width:100%">
                <el-table-column label="ID" prop="id" width="65" align="center"/>
                <el-table-column label="分类" prop="goods_type_name" width="100" align="center"/>
                <el-table-column label="产品名称" prop="goods_name" min-width="120"/>
                <el-table-column label="起投金额" prop="goods_money" width="100" align="right"/>
                <el-table-column label="每日分红" prop="day_red" width="100" align="center"/>
                <el-table-column label="投资周期" prop="period" width="100" align="center"/>
                <el-table-column label="项目规模" prop="project_scale" width="100" align="center"/>
                <el-table-column label="投资进度" prop="progress_rate" width="100" align="center"/>
                <el-table-column label="VIP等级" prop="level_vip" width="80" align="center">
                    <template slot-scope="scope">
                        <el-tag v-if="scope.row.level_vip>0" size="mini" type="warning">V{{ scope.row.level_vip }}</el-tag>
                        <span v-else class="text-muted">不限</span>
                    </template>
                </el-table-column>
                <el-table-column label="购买限制" prop="buy_num" width="80" align="center">
                    <template slot-scope="scope">
                        <span v-if="scope.row.buy_num>0">{{ scope.row.buy_num }}次</span>
                        <span v-else class="text-muted">不限</span>
                    </template>
                </el-table-column>
                <el-table-column label="一级返佣" prop="goods_agent_1" width="80" align="right"/>
                <el-table-column label="二级返佣" prop="goods_agent_2" width="80" align="right"/>
                <el-table-column label="三级返佣" prop="goods_agent_3" width="80" align="right"/>
                <el-table-column label="上架" width="70" align="center">
                    <template slot-scope="scope">
                        <el-tag :type="scope.row.status==1?'success':'info'" size="mini" effect="dark">
                            {{ scope.row.status==1?'已上架':'已下架' }}
                        </el-tag>
                    </template>
                </el-table-column>
                <el-table-column label="新手体验" width="80" align="center">
                    <template slot-scope="scope">
                        <el-tag :type="scope.row.is_examine==1?'primary':'info'" size="mini" effect="plain">
                            {{ scope.row.is_examine==1?'是':'否' }}
                        </el-tag>
                    </template>
                </el-table-column>
                <el-table-column label="优惠券" width="70" align="center">
                    <template slot-scope="scope">
                        <el-tag :type="scope.row.is_coupon==1?'primary':'info'" size="mini" effect="plain">
                            {{ scope.row.is_coupon==1?'可用':'不可' }}
                        </el-tag>
                    </template>
                </el-table-column>
                <el-table-column label="权重" prop="sort" width="60" align="center"/>
                <el-table-column label="类型" prop="red_way_text" width="110" align="center"/>
                <el-table-column label="担保公司" prop="warrant" width="110"/>
                <el-table-column label="添加时间" prop="create_time" width="150" align="center"/>
                <el-table-column fixed="right" label="操作" width="130" align="center">
                    <template slot-scope="scope">
                        <el-button type="primary" size="mini" plain icon="el-icon-edit" @click="handleShowDialog('edit',scope.row)">编辑</el-button>
                        <el-button type="danger" size="mini" plain icon="el-icon-delete" @click="productDel(scope.row)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </div>
        <div class="pagination-wrap">
            <el-pagination
                @current-change="handleCurrentChange"
                @size-change="handleSizeChange"
                :current-page="current"
                :page-sizes="[10, 20, 50, 100]"
                :page-size="pageSize"
                layout="sizes, total, prev, pager, next, jumper"
                :total="allpage">
            </el-pagination>
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
                <el-form-item label="每日分红">
                    <el-input v-model="form.day_red"></el-input>
                </el-form-item>
                <el-form-item label="投资周期">
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
    import {getProductV2ListApi, productV2EditApi, productV2AddApi, productV2DelApi} from '@/api/ProductV2'
    import {getProductClassListApi} from '@/api/Product'
    import {baseUrl} from "@/utils/config.js";
    import axios from "axios"
    export default {
        data() {
            return {
                dialogTitle: '产品V2',
                dataList: [],
                dataClassList: [],
                allpage: 1,
                showItem: 5,
                current: 1,
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
        },
        methods: {
            getProductClassList() {
                getProductClassListApi({page: 1, limit: 99999}).then(res => {
                    this.dataClassList = res.data.data
                })
            },
            getProductList() {
                getProductV2ListApi({page: this.current, limit: this.pageSize}).then(res => {
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
                    productV2DelApi({id: scope.id}).then(res => {
                        if (res.code == 1) {
                            this.$message({message: '删除成功', type: 'success'});
                            this.getProductList();
                        }
                    })
                }).catch(() => {})
            },
            productEdit() {
                productV2EditApi(this.form).then(res => {
                    if (res.code == 1) {
                        this.$message({message: res.msg, type: 'success'});
                        this.showDialog = false
                        this.getProductList()
                    }
                })
            },
            productAdd() {
                productV2AddApi(this.form).then(res => {
                    if (res.code == 1) {
                        this.$message({message: res.msg, type: 'success'});
                        this.showDialog = false
                        this.getProductList()
                    }
                })
            },
            handleShowDialog(type, rowData) {
                this.editProductType = type
                this.showDialog = true
                this.imageList = []
                if (type == 'edit') {
                    rowData.oldImgPath = rowData.pic_path
                    this.form = {...rowData}
                    return
                }
                if (type == 'add') {
                    this.form = {is_open: 1}
                }
            },
            handleCurrentChange(index) {
                this.current = index;
                this.getProductList()
            },
            handleSizeChange(val) {
                this.pageSize = val;
                this.current = 1;
                this.getProductList();
            },
            headerCellStyle() {
                return { background: '#f0f4ff', color: '#303133', fontWeight: '600', fontSize: '13px', borderBottom: '2px solid #dce6ff' };
            },
            cellStyle() {
                return { fontSize: '13px', color: '#606266' };
            },
            onSubmit() {
                if (this.editProductType == 'edit') {
                    this.productEdit()
                    return
                }
                if (this.editProductType == 'add') {
                    this.productAdd()
                }
            },
            handleAvatarError: function(error) {
                window.wxc.xcConfirm(error, window.wxc.xcConfirm.typeEnum.error);
            },
            handleRemove: function() {
                this.form.head_img = this.form.oldImgPath
            },
            uploadFile: function(file) {
                var fm = new FormData();
                fm.append('file', file.file);
                axios.post('/upload/video', fm).then(res => {
                    this.form.head_img = res.data.data[1][0]
                    this.imageList.push({url: res.data.data[0], uid: file.file.uid});
                });
            },
            handleRemove1: function() {
                this.form.bottom_img = this.form.oldImgPath
            },
            uploadFile1: function(file) {
                var fm = new FormData();
                fm.append('file', file.file);
                axios.post('/upload/video', fm).then(res => {
                    this.form.bottom_img = res.data.data[1][0]
                    this.imageList.push({url: res.data.data[0], uid: file.file.uid});
                });
            },
        },
    }
</script>

<style lang='scss' scoped>
.page-content {
    width: 100%;
    height: 100%;
    background: #f5f7fa;
    padding: 16px;
    box-sizing: border-box;
}

.toolbar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    background: #fff;
    border-radius: 8px;
    padding: 14px 20px;
    margin-bottom: 14px;
    box-shadow: 0 1px 6px rgba(0,0,0,0.06);
}

.toolbar-title {
    font-size: 16px;
    font-weight: 600;
    color: #1a1a2e;
    letter-spacing: 0.5px;
}

.btn-add {
    background: linear-gradient(135deg, #4f7cff, #6a5acd);
    border: none;
    border-radius: 6px;
    padding: 8px 18px;
    font-size: 13px;
    &:hover {
        background: linear-gradient(135deg, #3a6aee, #5a4abd);
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(79,124,255,0.35);
    }
}

.table-wrap {
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 1px 6px rgba(0,0,0,0.06);
    overflow: hidden;
}

.pagination-wrap {
    display: flex;
    justify-content: flex-end;
    padding: 12px 0 4px;
}

.text-muted {
    color: #c0c4cc;
    font-size: 12px;
}

>>> .el-table th {
    background: #f0f4ff !important;
}
>>> .el-table--striped .el-table__body tr.el-table__row--striped td {
    background: #fafbff;
}
>>> .el-table tbody tr:hover > td {
    background: #eef2ff !important;
}
>>> .el-table::-webkit-scrollbar {
    width: 6px;
    height: 6px;
}
>>> .el-table__body-wrapper::-webkit-scrollbar {
    width: 6px;
    height: 6px;
}
>>> .el-table__body-wrapper::-webkit-scrollbar-track {
    border-radius: 10px;
    background-color: #f0f0f0;
}
>>> .el-table__body-wrapper::-webkit-scrollbar-thumb {
    border-radius: 10px;
    background-color: #c0c4cc;
    &:hover { background-color: #909399; }
}
</style>
