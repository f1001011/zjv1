<template>
  <div class='page-content'>
    <el-row :gutter="20">
      <el-col :xs="24" :sm="12" :lg="4">
        <el-input placeholder="标题" v-model="searchParameter.title"></el-input>
      </el-col>
    </el-row>
    <el-row>
      <el-col :xs="24" :sm="12" :lg="4" class="el-col2" style="margin-top: 10px;">
        <el-button @click="search">搜索</el-button>
        <el-button @click="showDialog('add')">新增</el-button>
      </el-col>
    </el-row>
    <el-table style="margin-top: 15px" border :data="roleList" :showPage="false">
      <el-table-column label="标题" prop="title" />
      <el-table-column label="捐钱金额" prop="amount" />
      <el-table-column label="捐钱人数" prop="people" />
      <el-table-column label="民政备案号" prop="record_no" />
      <el-table-column label="标签" prop="labels" />
      <el-table-column label="收款机构" prop="collection_agency" />
      <el-table-column label="执行机构" prop="executing_agency" />
      <el-table-column label="是否上架" prop="type">
        <template slot-scope="scope">
          <el-tag size="mini" :type="scope.row.type ? '' : 'info'">
            {{scope.row.type == 1 ? '正常' : '下架'}}
          </el-tag>
          <el-switch   v-model="scope.row.type" @change="changes(scope.row.type,scope.row)" :active-value="1" :inactive-value="0"></el-switch>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" prop="create_time" />
      <el-table-column fixed="right" label="操作" width="150px">
        <template slot-scope="scope">
          <el-button type="text" icon="el-icon-edit" @click="showDialog('edit',scope.row)">
            编辑
          </el-button>
          <el-button type="text" style="color: #FA6962" icon="el-icon-delete" @click="deleteUser(scope.row)">
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-dialog :before-close="handleClose" :title="dialogTitle" width="50%" :visible.sync="dvEdit">
      <el-form ref="form" :model="form" label-width="50%">
        <div class="form">
          <el-row style="display: flex">
            <el-input v-model="form.title" placeholder="输入标题" style="flex: 1" />
            <el-input v-model="form.record_no" placeholder="民政备案号" style="flex: 1" />
          </el-row>
          <el-row style="display: flex">
            <el-input v-model="form.labels" placeholder="标签" style="flex: 1" />
          </el-row>
          <el-row style="display: flex;margin-top: 8px;">
            <el-input v-model="form.collection_agency" placeholder="收款机构" style="flex: 1" />
            <el-input v-model="form.executing_agency" placeholder="执行机构" style="flex: 1" />
          </el-row>
          <quill-editor style="margin-top: 8px;" class="editor" ref="quillEditor" v-model="form.content" :options="editorOption"/>
          <quill-editor style="margin-top: 8px;" class="editor" ref="quillEditor" v-model="form.progress_content" :options="editorOption"/>
          <!-- <el-input v-model="form.progress_content" type="textarea" :rows="4" placeholder="简介" /> -->
          <el-row style="margin-top: 20px">
            <el-upload enctype="multipart/form-data" class="upload-demo" :action="uploadImage"
              accept=".jpg,.png,.mp4,.avi" name="file" :limit="1" :on-error="handleAvatarError"
              :on-remove="handleRemove" :file-list="imageList" :http-request="uploadFile" list-type="picture">
              <el-button size="small" type="primary">封面点击上传</el-button>
              <div slot="tip" class="el-upload__tip"></div>
            </el-upload>
          </el-row>
        </div>

      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dvEdit = false">取 消</el-button>
        <el-button type="primary" @click="onSubmit">确 定</el-button>
      </span>
    </el-dialog>
    <template v-if="allpage>10">
      <el-pagination @current-change="handleCurrentChange" :current-page="1" :page-size="10"
        layout="total, prev, pager, next, jumper" :total="allpage">
      </el-pagination>
    </template>
  </div>
</template>

<script>
  import {
    getWelfareListApi,
    getWelfareEditApi,
    getWelfareDelApi,
    getWelfareAddApi,
    getWelfareGroundingApi
  } from '@/api/WelfareApi'

  import {getUploadDataApi} from '@/api/UploadApi'
  import quillConfig from "@/utils/quill-config.js";
  import {baseUrl} from "@/utils/config.js";
  import axios from "axios"
  export default {
    data() {
      return {
        allpage: 1, //总页数
        showItem: 5, //分页显示得中间按钮个数
        current: 1, //当前页
        dvEdit: false,
        dialogTitle: '',
        form: {
          username: '',
          desc: '',
        },
        editorOption: quillConfig,
        searchParameter: {
          title: undefined,
        },
        props: {
          label: 'name',
          children: 'zones'
        },
        options: [],
        articleTypeList: [],
        count: 1,
        roleList: [],
        imageList: [],
        uploadImage: baseUrl + '/upload/video'
      };
    },
    mounted() {
      this.getUserList();
    },
    methods: {
      changes(type,row){
          getWelfareGroundingApi({
            id:row.id,
            type:type,
            }).then(res => {
              if(res.code == 1){
               this.$message({message:res.msg,type: 'success'});
                return;
              }
          })
      },
      handleCurrentChange: function(index) {
        this.current = index;
        getWelfareListApi({
          page: index,
        }).then(res => {
          this.roleList = res.data.data;
          this.allpage = res.data.total;
        })
      },
      getUserList() {
        getWelfareListApi(this.searchParameter).then(res => {
          this.roleList = res.data.data
          this.allpage = res.data.total;

        })
      },

      handleRemove: function(file, fileList) {
        this.imageList = fileList;
      },
      //图片上传
      uploadFile: function(file) {
        var fm = new FormData();
        fm.append('file', file.file);
        axios.post('/upload/video', fm).then(res => {

          var arr = {
            'url': res.data.data[0],
            'uid': file.file.uid,
          };
          console.log(res.data.data)
          this.imageList.push(arr);
        });
      },
      handleAvatarError: function(error, file) {
        window.wxc.xcConfirm(error, window.wxc.xcConfirm.typeEnum.error);
      },
      handleClose(done) {
        this.$confirm('确认关闭？')
          .then(_ => {
            done();
          })
          .catch(_ => {});
      },
      search() {
        this.getUserList()
      },

      //富文本去除标签
      escapeStringHTML(str) {
        str = str.replace('<p>', '') //去除自带的p标签
         str = str.replace(/&lt;/g,'<');
         str = str.replace(/&gt;/g,'>');
         return str;
       },
      showDialog(type, row) {
        this.imageList = [];
        if (type == 'edit') {
          this.form = row;
          if (row.img_path) {
            var image = row.img_path.split(',');
            for (let i = 0; i < image.length; i++) {
              var arr = {
                'url': image[i],
                'uid': Math.round(Math.random() * 100000000)
              };
              this.imageList.push(arr);
            }
          }
          // if(this.form.content){
          //   this.form.content = this.escapeStringHTML(this.form.content);
          //   console.log(this.form.content);
          // }
          // if(this.form.progress_content){
          //   this.form.progress_content = this.escapeStringHTML(this.form.progress_content);
          // }
        } else {
          this.imageList = [];
          this.form = {};
        }
        this.dialogTitle = type === 'add' ? '新增' : '编辑'
        this.dvEdit = true; //
      },
      onSubmit() {
        this.form.img_path = this.imageList
        if (this.form.id) {
          getWelfareEditApi(this.form).then(res => {
            if (res.code == 1) {
              this.dvEdit = false
              this.$message({
                message: res.msg,
                type: 'success'
              });
              this.handleCurrentChange(this.current);
              return;
            }
          })
          return;
        }
        getWelfareAddApi(this.form).then(res => {
          if (res.code == 1) {
            this.dvEdit = false
            this.$message({
              message: res.msg,
              type: 'success'
            });
            this.getUserList();
            return;
          }
        })
      },
      loadNode(node, resolve) {
        if (node.level === 0) {
          return resolve([{
              name: '监控中心'
            },
            {
              name: '文章管理'
            },
            {
              name: '用户管理'
            },
            {
              name: '菜单管理'
            },
            {
              name: '个性设置'
            },
            {
              name: '异常管理'
            },
            {
              name: '系统设置'
            },
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
        this.$confirm('您确定要删除当前文章吗', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'error'
        }).then(() => {
          getWelfareDelApi({
            'id': scope.id
          }).then(res => {
            if (res.code == 1) {
              this.$message({
                message: '删除成功',
                type: 'success'
              });
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
    height: 50%;
  }
  >>> .el-dialog__body {
    padding:0 20px;
  }
  >>> .ql-editor {
    min-height:150px;
  }
</style>
