<template>
  <div class='page-content'>
    <el-row :gutter="20">

      <el-col :xs="24" :sm="12" :lg="4" class="el-col2">
        <el-button @click="handleShowDialog('add',{})">新增商品</el-button>
      </el-col>
    </el-row>
    <div>
      <el-table height="80vh" border style="margin-top: 15px" :data="dataList" :showPage="false">
        <el-table-column label="ID" prop="id" width="80" />
        <el-table-column label="商品名称" prop="wares_name" width="100" />
        <el-table-column label="商品图片" prop="head_img" align="center" width="100">
          <template slot-scope="scope">
            <el-image
              @click="
                bigImg(scope.row.head_img)
              "
              style="width: 50px; height: 50px; margin-bottom:-4px"
              :src="scope.row.head_img"
              :preview-src-list="srcList"
            >
            </el-image>
          </template>
        </el-table-column>
        <el-table-column label="需要积分" prop="wares_money" width="100" />
        <el-table-column label="商品规格" prop="wares_spec" width="100" />
        <el-table-column label="商品介绍" prop="content" :show-overflow-tooltip='true'  width="100" />
        <el-table-column label="是否启用" prop="status" width="">
          <template slot-scope="scope">
            <div>{{scope.row.status==0?'下架':'上架'}}</div>
          </template>
        </el-table-column>
        <el-table-column label="添加时间" prop="create_time" width="120" />

        <el-table-column fixed="right" label="操作" width="150px">
          <template slot-scope="scope">
            <el-button type="text" icon="el-icon-edit" @click="handleShowDialog('edit',scope.row)">
              编辑
            </el-button>
           <!-- <el-button type="text" style="color: #FA6962" icon="el-icon-delete" @click="productDel(scope.row)">
              删除
            </el-button> -->
          </template>
        </el-table-column>
      </el-table>
    </div>
    <div>
      <template v-if="allpage>10">
        <el-pagination @current-change="handleCurrentChange" @size-change="handleSizeChange" :current-page="current" :page-sizes="[10, 20, 50, 100]" :page-size="pageSize"
          layout="sizes, total, prev, pager, next, jumper" :total="allpage">
        </el-pagination>
      </template>
    </div>

    <el-dialog :title="dialogTitle" width="700px" :visible.sync="showDialog">
      <el-form ref="form" :model="form" label-width="80px">

        <el-form-item label="商品名称">
          <el-input v-model="form.wares_name"></el-input>
        </el-form-item>
        <el-form-item label="需要积分">
          <el-input v-model="form.wares_money"></el-input>
        </el-form-item>
        <el-form-item label="商品规格">
          <el-input v-model="form.wares_spec"></el-input>
        </el-form-item>
        <el-form-item label="是否上架">
          <el-radio-group v-model="form.status">
            <el-radio :label="1">是</el-radio>
            <el-radio :label="0">否</el-radio>
          </el-radio-group>
        </el-form-item>

        <el-form-item label="产品图片">
          <el-upload v-if="showDialog" enctype="multipart/form-data" class="upload-demo" :action="uploadImage"
            accept=".jpg,.png,.mp4,.avi" name="file" :limit="1" :on-error="handleAvatarError" :on-remove="handleRemove"
            :http-request="uploadFile" list-type="picture">
            <el-button size="small" type="primary">封面点击上传</el-button>
            <div slot="tip" class="el-upload__tip">
              <img :src="form.head_img" alt="" style="width: 100px;height:auto">
            </div>
          </el-upload>
        </el-form-item>
        <el-form-item label="产品介绍">
            <quill-editor class="editor" ref="quillEditor" v-model="form.content" :options="editorOption"/>
        </el-form-item>
        <!-- <el-form-item label="详情下图">
          <el-upload v-if="showDialog" enctype="multipart/form-data" class="upload-demo" :action="uploadImage"
            accept=".jpg,.png,.mp4,.avi" name="file" :limit="1" :on-error="handleAvatarError" :on-remove="handleRemove1"
            :http-request="uploadFile1" list-type="picture">
            <el-button size="small" type="primary">封面点击上传</el-button>
            <div slot="tip" class="el-upload__tip">
              <img :src="form.bottom_img" alt="" style="width: 100px;height:auto">
            </div>
          </el-upload>
        </el-form-item> -->
<!--
        <el-form-item label="排序" prop="sort">
          <el-input v-model.number="form.sort" placeholder="数值越小排名越前"></el-input>
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
  import {
    getWaresListApi,
    waresEditApi,
    waresAddApi,
    waresDelApi,
  } from '@/api/Wares'
  import quillConfig from "@/utils/quill-config.js";
  import {
    baseUrl
  } from "@/utils/config.js";
  import axios from "axios"
  export default {
    data() {
      return {
        dialogTitle: '产品',
        dataList: [],
        dataClassList: [],
        dataLevelList: [],
        srcList:[
          "https://fuss10.elemecdn.com/8/27/f01c15bb73e1ef3793e64e6b7bbccjpeg.jpeg",
        ],
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
      this.getProductList()
    },
    mounted() {},
    methods: {
      /**
       *  获取产品列表
       */
      getProductList() {
        let data = {
          page: this.current,
          limit: this.pageSize,
        }
        getWaresListApi(data).then(res => {
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
        waresEditApi(this.form).then(res => {
          if (res.code == 1) {
            this.$message({
              message: res.msg,
              type: 'success'
            });
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
        waresAddApi(this.form).then(res => {
          if (res.code == 1) {
            this.$message({
              message: res.msg,
              type: 'success'
            });
            this.showDialog = false
            this.getProductList()
            return;
          }

        })
      },
      //大图
      bigImg(url) {
        this.srcList[0] = url;
      },
      /**
       * 展示对话框
       */
      handleShowDialog(type, rowData) {
        this.editProductType = type
        this.showDialog = true
        this.imageList = []
        if (this.editProductType == 'edit') {
          // console.log("rowData:",rowData)
          rowData.oldImgPath = rowData.pic_path
          this.form = {
            ...rowData
          }
          return
        }
        if (this.editProductType == 'add') {
          this.form = {
            is_open: 1
          }

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
      onSubmit() {


        if (this.editProductType == 'edit') {

          this.productEdit()
          return
        }
        if (this.editProductType == 'add') {
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

  >>>.el-table::-webkit-scrollbar {
    width: 8px !important;
    /*滚动条宽度*/
    height: 8px !important;
    /*滚动条高度*/
  }

  >>>.el-table__body-wrapper::-webkit-scrollbar {
    width: 8px !important;
    /*滚动条宽度*/
    height: 8px !important;
    /*滚动条高度*/
  }

  >>>.el-table__body-wrapper::-webkit-scrollbar-track {
    border-radius: 10px;
    /*滚动条的背景区域的圆角*/
    -webkit-box-shadow: inset 0 0 6px rgba(238, 238, 238, 0.3);
    background-color: #eeeeee;
    /*滚动条的背景颜色*/
  }

  >>>.el-table__body-wrapper::-webkit-scrollbar-thumb {
    border-radius: 10px;
    /*滚动条的圆角*/
    -webkit-box-shadow: inset 0 0 6px rgba(145, 143, 0143, 0.3);
    background-color: rgb(145, 143, 143);
    /*滚动条的背景颜色*/
  }
 >>> .ql-container {
   height: 300px;
 }
 .box{}
     .el-image-viewer__mask {
      background: none !important;
    }
   .el-image-viewer__close {
     top: 40px;
     right: 40px;
     width: 40px;
     height: 40px;
     font-size: 24px;
     color: #fff;
     background-color:rgba(255, 255, 255, 0)!important;
 }
</style>
