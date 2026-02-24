<template>
    <div class='page-content'>
        <el-row :gutter="20">
            <el-col :xs="24" :sm="12" :lg="4">
                <el-select v-model="currentType.id"  placeholder="排行类型"  @change="handleRanking($event)"
                :style="{width: '100%'}">
                    <el-option v-for="(item,index) in rankingType" :key="index" :label="item.label" :value="item.id">
                    </el-option>
                </el-select>
            </el-col>
            <el-col :xs="24" :sm="12" :lg="4">
                <el-select v-model="status"  placeholder="排序"  @change="handleStatusRanking($event)"
                :style="{width: '100%'}">
                    <el-option v-for="(item,index) in statusType" :key="index" :label="item.label" :value="item.status">
                    </el-option>
                </el-select>
            </el-col>
          <el-col :xs="24" :sm="12" :lg="4" v-if="myInfo.role !== 2">
            <el-select clearable v-model="dailishang"  :placeholder="String(dailishang) ? String(dailishang) : '全部'"  @change="handleDailiRanking($event)"
                       :style="{width: '100%'}">
              <el-option v-for="(item,index) in dailishangData" :key="index" :label="item.user_name" :value="item.id">
              </el-option>
            </el-select>
          </el-col>
        </el-row>
        <div>
            <el-table style="margin-top: 15px" border  :showPage="false" :data="dataList">
                <!-- <el-table-column label="ID" width="80" prop="id" /> -->


                <el-table-column label="用户名称" width="" prop="user_name" />
                <el-table-column label="电话" width="" prop="phone" />
                <el-table-column :label="currentTypeName[0].label+'数量'" width="" prop="num" />
                <el-table-column label="排行榜" width="" prop="sort"  />
                <!-- <el-table-column label="邀请榜" width="" prop="sort" v-if="currentType.id==1" />
                <el-table-column label="充值" width="" prop="sort" v-if="currentType.id==2"/>
                <el-table-column label="提现" width="" prop="sort" v-if="currentType.id==3"/>
                <el-table-column label="PHP俑金" width="" prop="sort" v-if="currentType.id==4"/>
                <el-table-column label="USDT余额" width="" prop="sort" v-if="currentType.id==5"/> -->
                <!-- <el-table-column fixed="right" label="操作" width="150px">
                    <template slot-scope="scope">
                    <el-button type="text" icon="el-icon-edit" @click="showDialog('edit',scope.row)">
                        编辑
                    </el-button>
                    <el-button type="text" style="color: #FA6962" icon="el-icon-delete" @click="deleteUser(scope.row)">
                        删除
                    </el-button>
                    </template>
                </el-table-column> -->
              <el-table-column fixed="right" label="操作" width="150px">
                  <template slot-scope="scope">
                    <el-button type="text" icon="el-icon-document-copy" @click="detailHandle(scope.row)">详情</el-button>
                  </template>
              </el-table-column>
            </el-table>
        </div>
    </div>
</template>

<script>
  import {getUserRankingApi,getDaiLiShangData} from '@/api/userApi'
  export default {
        data() {
            return {
              dailishang: '',
                statusType: [{
                    status: "0",
                    label: '由高到低'
                },{
                    status: "1",
                    label: '由低到高'
                },],
                rankingType: [
                    {
                      id: "1",
                      label: '邀请购买人数'
                    },
                    {
                        id: "2",
                        label: '用户购买产品总金额'
                    },
                    {
                        id: "3",
                        label: '累计获得佣金总合'
                    },
                    {
                        id: "4",
                        label: 'PHP余额'
                    },
                    {
                        id: "5",
                        label: 'usdt余额'
                    },
                    {
                      id: '6',
                      label: '人数统计'
                    }
                ],
                currentType: {id:''},
                currentTypeName: [],
                status: '0',
                dataList: [],
                dailishangData: [],
                myInfo: {}
            };
        },
        created() {
            this.currentType = JSON.parse(JSON.stringify(this.rankingType[0]))
            this.currentTypeName[0] = JSON.parse(JSON.stringify(this.rankingType[0]))
        },
        mounted() {
            this.getDaiLiShangData()
            this.getUserRanking()
            // 获取账号信息
            this.myInfo = JSON.parse(localStorage.getItem('myInfo'))
        },
        methods: {
            // 点击详情处理事件
            detailHandle(row) {
              this.$router.push({
                path: '/user/userlist',
                query: {
                  phone: row.phone
                }
              })
            },
            // 代理商选择事件
            handleDailiRanking(e) {
              this.dailishang = e
              getUserRankingApi({
                agents: this.dailishang,
                type:this.currentType.id,
                status: this.status
              }).then(res => {
                console.log(res);
                this.dataList = res.data
                this.dataList.forEach(el => {
                  if(el.user_id) {
                    el.id = el.user_id
                  }
                })
              })
            },

            // 获取代理商数据
            getDaiLiShangData() {
              getDaiLiShangData({
                agents: this.dailishang
              }).then(res => {
                console.log(res);
                this.dailishangData = res.data
              })
            },
            getUserRanking(){
                getUserRankingApi({type:this.currentType.id,status: this.status}).then(res => {
                    this.dataList = res.data
                    this.dataList.forEach(el => {
                        if(el.user_id) {
                            el.id = el.user_id
                        }
                    })
                })
            },
            handleRanking(id) {
                this.currentTypeName = this.rankingType.filter((item) => {
                    return item.id == id
                })
                this.getUserRanking()
            },
            handleStatusRanking(status) {
                this.getUserRanking()
            }
        },
  }
</script>

<style lang='scss' scoped>
    .page-content {
        width: 100%;
        height: 100%;
    }
</style>
