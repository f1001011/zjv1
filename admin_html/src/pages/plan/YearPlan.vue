<template>
  <div class='page-content'>
    <el-row :gutter="20" style="padding: 0 10px">
      <el-button type="primary" style="width: 75px" @click="showDialog('add')">新建</el-button>
    </el-row>
    <tao-table :data="tableData" :showPage="false" style="margin-top: 15px">
      <el-table-column label="计划事项" prop="title"/>
      <el-table-column label="进度" prop="percentage">
        <template slot-scope="scope">
          {{scope.row.percentage}}%
        </template>
      </el-table-column>
      <el-table-column prop="startDate" label="开始时间"/>
      <el-table-column prop="endDate" label="结束时间"/>
      <el-table-column fixed="right" label="操作" width="150px">
        <template>
          <el-button type="text" icon="el-icon-edit" @click="showDialog('edit')">
            编辑
          </el-button>
          <el-button type="text" style="color: #FA6962" icon="el-icon-delete" @click="deletePlan">
            删除
          </el-button>
        </template>
      </el-table-column>
    </tao-table>

    <el-dialog :title="dialogTitle" width="500px" :visible.sync="dvEdit" top="30vh">
      <el-form ref="form" :model="form" label-width="70px">
        <el-form-item label="计划名称">
          <el-input v-model="form.name"></el-input>
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="dvEdit = false">取 消</el-button>
        <el-button type="primary" @click="onSubmit">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
  export default {
    data () {
      return {
        dvEdit: false,
        dialogTitle: '',
        form: {
          name: ''
        },
        tableData: [
          {
            title: '学习Flutter',
            startDate: '2020-1-1',
            endDate: '2020-12-31',
            percentage: 100,
            color: '#93CDFF'
          },
          {
            title: '六块腹肌',
            startDate: '2020-1-1',
            endDate: '2020-12-31',
            percentage: 0,
            color: '#E6A23C'
          },
          {
            title: '网站重构',
            startDate: '2020-1-1',
            endDate: '2020-12-31',
            percentage: 100,
            color: '#FF909D'
          },
          {
            title: 'Golang',
            startDate: '2020-1-1',
            endDate: '2020-12-31',
            percentage: 100,
            color: '#B7CBE2'
          },
          {
            title: 'TypeScript',
            startDate: '2020-1-1',
            endDate: '2020-12-31',
            percentage: 70,
            color: '#909399'
          },
          {
            title: 'HTTP',
            startDate: '2020-1-1',
            endDate: '2020-12-31',
            percentage: 60,
            color: '#9BB4F3'
          },
          {
            title: '设计模式',
            startDate: '2020-1-1',
            endDate: '2020-12-31',
            percentage: 20,
            color: '#F2B985'
          },
          {
            title: '算法',
            startDate: '2020-1-1',
            endDate: '2020-12-31',
            percentage: 20,
            color: '#F5B7CE'
          },
          {
            title: 'Node.js',
            startDate: '2020-1-1',
            endDate: '2020-12-31',
            percentage: 20,
            color: '#7CC6DD'
          },
          {
            title: 'Vue深入学习',
            startDate: '2020-1-1',
            endDate: '2020-12-31',
            percentage: 60,
            color: '#FF9C80'
          },
          {
            title: 'JavaScript深度指南',
            startDate: '2020-1-1',
            endDate: '2020-12-31',
            percentage: 30,
            color: '#FBBE66'
          },
          {
            title: 'Git版本控制',
            startDate: '2020-1-1',
            endDate: '2020-12-31',
            percentage: 90,
            color: '#A8CCFD'
          },
          {
            title: 'this指向问题 全解析',
            startDate: '2020-1-1',
            endDate: '2020-12-31',
            percentage: 70,
            color: '#7690FF'
          },
          {
            title: '正则表达式 深度指南',
            startDate: '2020-1-1',
            endDate: '2020-12-31',
            percentage: 50,
            color: '#FD8D8C'
          },
          {
            title: '颠覆认知的『前端面试题合集』',
            startDate: '2020-1-1',
            endDate: '2020-12-31',
            percentage: 80,
            color: '#C0D7F3'
          },
          {
            title: '前端开发『造轮子』高级程序设计合集',
            startDate: '2020-1-1',
            endDate: '2020-12-31',
            percentage: 100,
            color: '#B7CBE2'
          }
        ],
      };
    },
    methods: {
      showDialog(type) {
        this.dvEdit = true
        this.dialogTitle = type === 'add' ? '新增' : '编辑'
      },
      onSubmit() {
        this.dvEdit = false
      },
      deletePlan() {
        this.$confirm('确定要删除吗', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'error'
        }).then(() => {
          
        }).catch(() => {})
      }
    }
  }
</script>

<style lang="scss">
  // 进度动画
  .el-progress-bar__inner {
    transition: all 1s !important;
  }
</style>

<style lang='scss' scoped>
  .page-content {
    width: 100%;
    height: 100%;
  }
</style>