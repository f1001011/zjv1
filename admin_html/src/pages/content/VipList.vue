<template>
    <div class='page-content'>
        <div class="toolbar">
            <div class="toolbar-title">VIP等级管理</div>
            <el-button class="btn-add" type="primary" icon="el-icon-plus" @click="handleShowDialog('add', {})">新增等级</el-button>
        </div>
        <div class="table-wrap">
            <el-table
                height="calc(80vh - 100px)"
                :data="dataList"
                stripe
                :header-cell-style="headerCellStyle"
                :cell-style="cellStyle"
                style="width:100%">
                <el-table-column label="ID" prop="id" width="80" align="center"/>
                <el-table-column label="VIP等级" prop="vip" width="120" align="center">
                    <template slot-scope="scope">
                        <el-tag type="warning" effect="dark" size="small">VIP {{ scope.row.vip }}</el-tag>
                    </template>
                </el-table-column>
                <el-table-column label="所需经验值" prop="experience" align="center"/>
                <el-table-column fixed="right" label="操作" width="160" align="center">
                    <template slot-scope="scope">
                        <el-button type="primary" size="mini" plain icon="el-icon-edit" @click="handleShowDialog('edit', scope.row)">编辑</el-button>
                        <el-button type="danger" size="mini" plain icon="el-icon-delete" @click="handleDel(scope.row)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </div>
        <div class="pagination-wrap">
            <el-pagination
                @current-change="handleCurrentChange"
                @size-change="handleSizeChange"
                :current-page="current"
                :page-sizes="[10, 20, 50]"
                :page-size="pageSize"
                layout="sizes, total, prev, pager, next, jumper"
                :total="allpage">
            </el-pagination>
        </div>

        <el-dialog :title="dialogTitle" width="420px" :visible.sync="showDialog">
            <el-form ref="form" :model="form" label-width="110px">
                <el-form-item label="VIP等级">
                    <el-input v-model.number="form.vip" placeholder="请输入VIP等级数字，如 1、2、3"></el-input>
                </el-form-item>
                <el-form-item label="所需经验值">
                    <el-input v-model.number="form.experience" placeholder="升级到该等级所需经验值"></el-input>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="showDialog = false">取 消</el-button>
                <el-button type="primary" :loading="submitting" @click="onSubmit">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
    import { getVipListApi, addVipApi, editVipApi, delVipApi } from '@/api/VipApi'

    export default {
        data() {
            return {
                dialogTitle: 'VIP等级',
                dialogType: 'add',
                dataList: [],
                allpage: 0,
                current: 1,
                pageSize: 10,
                showDialog: false,
                submitting: false,
                form: { vip: '', experience: '' },
                headerCellStyle: { background: '#f5f7fa', color: '#606266', fontWeight: '600' },
                cellStyle: { padding: '8px 0' },
            }
        },
        created() {
            this.getList()
        },
        methods: {
            getList() {
                getVipListApi({ page: this.current, limit: this.pageSize }).then(res => {
                    if (res.data.code === 1) {
                        this.dataList = res.data.data.data
                        this.allpage = res.data.data.total
                    }
                })
            },
            handleShowDialog(type, row) {
                this.dialogType = type
                this.dialogTitle = type === 'add' ? '新增VIP等级' : '编辑VIP等级'
                this.form = type === 'add' ? { vip: '', experience: '' } : { ...row }
                this.showDialog = true
            },
            onSubmit() {
                if (this.form.vip === '' || this.form.vip === null) {
                    return this.$message.warning('请输入VIP等级')
                }
                if (this.form.experience === '' || this.form.experience === null) {
                    return this.$message.warning('请输入所需经验值')
                }
                this.submitting = true
                const api = this.dialogType === 'add' ? addVipApi : editVipApi
                api(this.form).then(res => {
                    if (res.data.code === 1) {
                        this.$message.success(this.dialogType === 'add' ? '添加成功' : '修改成功')
                        this.showDialog = false
                        this.getList()
                    } else {
                        this.$message.error(res.data.msg || '操作失败')
                    }
                }).finally(() => { this.submitting = false })
            },
            handleDel(row) {
                this.$confirm(`确定删除 VIP ${row.vip} 等级吗？`, '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    delVipApi({ id: row.id }).then(res => {
                        if (res.data.code === 1) {
                            this.$message.success('删除成功')
                            this.getList()
                        } else {
                            this.$message.error(res.data.msg || '删除失败')
                        }
                    })
                }).catch(() => {})
            },
            handleCurrentChange(val) {
                this.current = val
                this.getList()
            },
            handleSizeChange(val) {
                this.pageSize = val
                this.current = 1
                this.getList()
            },
        }
    }
</script>

<style lang="scss" scoped>
.page-content {
    padding: 20px;
    background: #fff;
    border-radius: 4px;
}
.toolbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 16px;
    .toolbar-title {
        font-size: 16px;
        font-weight: 600;
        color: #303133;
    }
}
.table-wrap {
    margin-bottom: 16px;
}
.pagination-wrap {
    display: flex;
    justify-content: flex-end;
}
</style>
