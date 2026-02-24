<template>
  <div class='page-content'>
    <el-row :gutter="20">
      <!-- <el-col :xs="24" :sm="12" :lg="4">
        <el-input placeholder="用户名或昵称"></el-input>
      </el-col> -->
      <el-col :xs="24" :sm="12" :lg="4" class="el-col2">
        <!-- <el-button>搜索</el-button> -->
        <el-button @click="showDialog('add')">新增</el-button>
      </el-col>
    </el-row>

    <el-table border style="margin-top: 15px" :data="roleList" :showPage="false">
      <!-- <el-table-column label="ID" prop="id"/> -->
      <el-table-column label="name" prop="name"/>
      <el-table-column label="value" prop="value"/>
      <el-table-column label="mark" prop="mark"/>
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

    <el-dialog :title="dialogTitle" width="500px" :visible.sync="dvEdit">
      <el-radio-group v-model="radio" style="margin-bottom: 10px;">
        <el-radio :label="1">文本</el-radio>
        <el-radio :label="2">图片</el-radio>
        <el-radio :label="3">富文本</el-radio>
      </el-radio-group>
      <!--文本-->
      <el-form ref="form" :model="form" label-width="60px" v-if="radio === 1">
        <el-form-item label="name">
          <el-input v-model="form.name"></el-input>
        </el-form-item>
        <el-form-item label="value">
          <el-input v-model="form.value"></el-input>
        </el-form-item>
        <el-form-item label="mark">
          <el-input v-model="form.mark"></el-input>
        </el-form-item>
      </el-form>
      <!--图片-->
      <el-form ref="form" :model="form" label-width="60px" v-if="radio === 2">
        <el-form-item label="name">
          <el-input v-model="form.name"></el-input>
        </el-form-item>
        <el-form-item label="value">
          <div style="display: flex; ">
            <div style="width:350px">
              <el-input v-model="form.value" ></el-input>
            </div>
            <div style="flex: 1">
              <el-upload enctype="multipart/form-data" class="upload-demo" :action="uploadImage"
                         accept=".jpg,.png,.mp4,.avi" name="file" :limit="1" :on-error="handleAvatarError"
                         :on-remove="handleRemove" :file-list="imageList" :http-request="uploadFile" list-type="picture">
                <el-button size="small" type="primary">上传图片</el-button>
                <div slot="tip" class="el-upload__tip"></div>
              </el-upload>
            </div>
          </div>
        </el-form-item>
        <el-form-item label="mark">
          <el-input v-model="form.mark"></el-input>
        </el-form-item>
      </el-form>
      <!--富文本-->
      <el-form ref="form" :model="form" label-width="60px" v-if="radio === 3">
        <el-form-item label="name">
          <el-input v-model="form.name"></el-input>
        </el-form-item>
        <el-form-item label="mark">
          <el-input v-model="form.mark"></el-input>
        </el-form-item>
        <!-- 富文本编辑器 -->
        <el-form-item label="内容：" prop="articleBody">
          <!-- 失去焦点时手动校验该字段 (当前 articleBody 属性值) -->
          <input
            type="file"
            ref="uploadInput"
            @change="EditorUpload"
            class="uploadImgEditor"
            name=""
            hidden
            id=""
          />
          <quill-editor
            class="editor"
            v-model="ruleForm.articleBody"
            :options="editorOption"
            ref="myTextEditor"
          >
          </quill-editor>
          <!--<quill-editor v-model="ruleForm.articleBody"/>-->
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="dvEdit = false">取 消</el-button>
        <el-button type="primary" @click="onSubmit">确 定</el-button>
      </span>
    </el-dialog>
    <template v-if="allpage>10">
          <el-pagination @current-change="handleCurrentChange"
             :current-page="1"
             :page-size="10"
             layout="total, prev, pager, next, jumper"
             :total="allpage">
          </el-pagination>
    </template>
  </div>
</template>

<script>
    import {baseUrl} from "@/utils/config.js";
  import {getConfigListApi, getConfigDelApi,getConfigEditApi,getConfigAddApi} from '@/api/SysConfigApi'
  import axios from "axios"
  export default {
    data () {
      return {
        editorOption: [],
        radio: 1,
        dvEdit: false,
        dialogTitle: '',
        allpage:10,
        form: {
          username: '',
          desc: '',
          value: ''
        },
        props: {
          label: 'name',
          children: 'zones'
        },
        count: 1,
        uploadImage: baseUrl + '/upload/video',
        imageList: [],
        roleList: [],

        ruleForm: {
          //...省略其他
          articleBody: '',
        },
      };
    },
    mounted() {
      this.getUserList()
    },
    created() {
      this.editorOption = {
        modules: {
          toolbar: {
            container: [
              ["bold", "italic", "underline", "strike"], // toggled buttons
              ["blockquote", "code-block"],
              [{ header: 1 }, { header: 2 }], // custom button values
              [{ list: "ordered" }, { list: "bullet" }],
              [{ script: "sub" }, { script: "super" }], // superscript/subscript
              [{ indent: "-1" }, { indent: "+1" }], // outdent/indent
              [{ direction: "rtl" }], // text direction
              [{ size: ["small", false, "large", "huge"] }], // custom dropdown
              [{ header: [1, 2, 3, 4, 5, 6, false] }],
              [{ color: [] }, { background: [] }], // dropdown with defaults from theme
              [{ font: [] }],
              [{ align: [] }],
              // ['link', 'image', 'video'],
              ["image"],
              ["clean"], // remove formatting button
            ], // 工具栏
            handlers: {
              image: function (value) {
                if (value) {
                  document.querySelector(".uploadImgEditor").click();
                } else {
                  this.quill.format("image", false);
                }
              },
            },
          },
        },
        placeholder: "请输入文章内容(必填项)", //提示
        readyOnly: false, //是否只读
        theme: "snow", //主题 snow/bubble
        syntax: true, //语法检测
      };
    },
    methods: {
      getUserList() {
        getConfigListApi().then(res => {
          this.roleList = res.data.data;
          this.allpage = res.data.total;
        })
      },
      EditorUpload() {
        var file = this.$refs.uploadInput.files[0];
        console.log(file);
        this.uploadFile('fuwenben',file)
        // this.uploadLogo(fd, file);
      },
      uploadLogo(dt, file) {
        console.log(file)
      },
      uploadFile: function(flag,file) {
        if (flag) {
          var fm = new FormData();
          fm.append('file', file);
          axios.post('/upload/video', fm).then(res => {
            let quill = this.$refs.myTextEditor.quill;//获取富文本编辑器dom对象
            let length = quill.getSelection().index;//光标位置
            quill.insertEmbed(length, "image", res.data.data[0]);
            quill.setSelection(length + 1);// 调整光标到最后
          });
          return
        }
        var fm = new FormData();
        fm.append('file', file.file);
        axios.post('/upload/video', fm).then(res => {
          var arr = {
              'url': res.data.data[0],
              'uid': file.file.uid,
          };
          // console.log(res.data.data)
          this.form.value = res.data.data[0]
          this.imageList.push(arr);
        });
    },
     showDialog(type, row) {
       this.dvEdit = true
       if (type === 'edit') {
         switch (row.type) {
           case 1:
             this.form = row
             this.radio = 1
             break;
           case 2:
             this.form = row
             this.radio = 2
             break;
           case 3:
             this.ruleForm.articleBody = row.value
             // row.value = ''
             this.form = row
             this.radio = 3
             break;
         }
         this.form = row
       }
       if (type === 'add') {
         this.form = {}
         this.ruleForm.articleBody = ''
       };
       this.dialogTitle = type === 'add' ? '新增' : '编辑'
     },
     onSubmit() {
       if (this.radio === 3) {
         this.form.value = this.ruleForm.articleBody
       }
       switch (this.radio) {
         case 1:
           this.form.type = 1
           break;
         case 2:
           this.form.type = 2
           break;
         case 3:
           this.form.type = 3
           break;
       }
       if (this.form.id) {
         getConfigEditApi(this.form).then(res => {
           if(res.code == 1){
            this.dvEdit = false
            this.$message.success(res.msg);
            console.log('11')
            this.getUserList();
             return;
           }
         })
         return;
       }
       getConfigAddApi(this.form).then(res => {
         if(res.code == 1){
          this.dvEdit = false
          this.$message.success(res.msg);
          this.getUserList();
           return;
         }
       })
     },
     handleCurrentChange:function(index){
               this.current = index;
               getConfigListApi({
                 page:index,
               }).then(res => {
                 this.roleList = res.data.data;
                 this.allpage = res.data.total;
               })
     },
    handleAvatarError: function(error, file) {
        window.wxc.xcConfirm(error, window.wxc.xcConfirm.typeEnum.error);
    },
    handleRemove: function(file, fileList) {
        this.imageList = fileList;
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
          getConfigDelApi({'id':scope.id}).then(res=>{
                if(res.code == 1){
                  this.$message.success(res.msg);
                  this.getUserList();
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
  >>> .ql-editor {

    // 样式穿透

    min-height: 180px !important;

  }
</style>
