<template>
  <div class="login">
    <div class="left-wrap" :style="{backgroundImage: `url(${leftBg})`}">
      <svg class="icon" aria-hidden="true">
        <use xlink:href="#iconzhaopian-copy"></use>
      </svg>

      <img class="left-img" src="@img/lf_icon.svg"/>
    </div>
    <div class="right-wrap">
      <div class="header">
        <svg class="icon" aria-hidden="true">
          <use xlink:href="#iconzhaopian-copy"></use>
        </svg>
        <h1>Tao Admin</h1>
      </div>
      <div class="login-wrap">
        <div class="form">
          <h3>登 录</h3>
         <!--<el-col style="margin-top: 30px">-->
         <!--   <span class="input-label">类型</span>-->
         <!--   &lt;!&ndash;<el-radio v-model.trim="type" label="1">管理员登陆</el-radio>&ndash;&gt;-->
         <!--   &lt;!&ndash;<el-radio v-model.trim="type" label="2">服务商登陆</el-radio>&ndash;&gt;-->
         <!-- </el-col>-->
          <el-col style="margin-top: 30px">
            <span class="input-label">账号</span>
            <el-input  size="medium" v-model.trim="account"/>
          </el-col>
          <el-col style="margin-top: 15px">
            <span class="input-label">密码</span>
            <el-input  size="medium" v-model.trim="password" type="password"
              autocomplete="off"
              @keyup.enter.native="login"
            />
          </el-col>
          <el-col style="margin-top: 30px">
            <span class="input-label">验证码</span>
            <el-input  size="medium" v-model.trim="captcha"/>
          </el-col>

          <el-col style="margin-top: 30px">
            <el-button class="login-btn" @click="login" :loading="loading">
              {{btnText}}
            </el-button>
          </el-col>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import setting from '@/config/setting'
  import { getCaptchaApi, loginApi,AgentloginApi  } from '@/api/loginApi'
  import {  setToken} from "@/utils/auth"
  import {  baseUrl } from "@/utils/config"


  export default {
    data () {
      return {
        account: '',
        password: '',
        type:'1',
        captcha: '',
        leftBg: require('@img/lf_bg.png'),
        loading: false,
        btnText: '登录',
        captcha:'',
        captchaUrl : baseUrl +'/login/captcha',
      }
    },
    mounted() {
      //this.getCaptcha()
    },
    methods: {
      //获取验证码
      // getCaptcha() {
      //       this.captchaUrl = baseUrl +'/login/captcha?t'+Math.random();
      // },
      // 登录
      login() {
        // let {account, password, code, captcha,type} = this
        let {account, password, captcha} = this
        if(!account) {
          this.$message.error('请输入账号')
          return
        }
        if(!captcha) {
          this.$message.error('请输入验证码')
          return
        }
        if(!password) {
          this.$message.error('请输入密码')
          return
        }
        let type =this.type;//后台管理员
        // if(!type){
        //    let type =1;//后台管理员
        // }

        // if(!type) {
        //   this.$message.error('请选择登陆类型')
        //   return
        // }

        localStorage.setItem('admin_type',type);

        if(type !=1){
          this.Agentlogin()
          console.log('进来了')
          return;
        }

        loginApi({
          user_name: account,
          pwd: password,
          captcha: captcha,
          captchaId: captcha.captchaId,
          admin_type:1
        }).then(res => {
          if(res.code === 1) {
            localStorage.setItem('myInfo', JSON.stringify(res.data.user))
            this.loading = true
            this.btnText = '登录中...'
            this.$store.dispatch('user/setUserInfo', res.data)
            this.$store.dispatch('user/setLoginStatus', true)
            setToken(res.data.token)
            setTimeout(() => {
              this.$router.push('/dashboard/console')
            }, 1000)
          }

          if(res.code === 7) {
            this.getCaptcha()
          }
        })
      },
      Agentlogin(){
        let {account, password, code, captcha,type} = this
        AgentloginApi({
          user_name: account,
          pwd: password,
          captcha: captcha,
          captchaId: captcha.captchaId,
          admin_type:2
        }).then(res => {
          if(res.code === 1) {
            this.loading = true
            this.btnText = '登录中...'
            localStorage.setItem('myInfo', res.data)
            this.$store.dispatch('user/setUserInfo', res.data)
            this.$store.dispatch('user/setLoginStatus', true)
            console.log(res.data.token)
            setToken(res.data.token)

            setTimeout(() => {
              this.$router.push('/platform/moneylog')
            }, 1000)
          }

          if(res.code === 7) {
            this.getCaptcha()
          }
        })
      }
    }
  }
</script>

<style lang="scss" scoped>
  .login {
    width: 100%;
    height: 100vh;
    box-sizing: border-box;
    display: flex;

    .icon {
      width: 32px;
      height: 32px;
    }

    /deep/ .el-input__inner {
      &:focus {
        border: 1px solid #4E83FD;
      }
    }

    /deep/ .el-input--medium .el-input__inner {
      height: 40px;
      line-height: 40px;
    }

    .left-wrap {
      width: 520px;
      height: 100%;
      background: #fff;
      background-size: cover;
      padding: 20px;
      box-sizing: border-box;

      .left-img {
        display: block;
        margin: auto;
        margin-top: 300px;
      }
    }

    .right-wrap {
      width: calc(100% - 520px);
      height: 100%;
      position: relative;

      .header {
        display: none;
      }

      .login-wrap{
        width: 440px;
        height: 550px;
        border-radius: 5px;
        overflow: hidden;
        position: absolute;
        left: 0;
        right: 0;
        top: 0;
        bottom: 0;
        margin: auto;
        background-size: cover;
        box-shadow: 0 0 10px rgba(28,76,186,.1);

        .form {
          widows: 100%;
          height: 100%;
          box-sizing: border-box;
          padding: 40px 30px;
          background: #fff;

          h3 {
            color: #555;
            font-size: 23px;
            text-align: center;
            font-weight: 500;
          }

          .input-label {
            color: #333;
            font-size: 14px;
            padding: 8px 0;
            display: block;
          }

          .code {
            display: flex;
            justify-content: space-between;

            .el-input {
              flex: 1;
              margin-right: 20px;
            }

            img {
              width: 115px;
              height: 40px;
              cursor: pointer;
              border-radius: 5px;
              background: #f8f8f8 !important;
            }
          }

          .login-btn {
            width: 100%;
            height: 40px;
            border: 0;
            color: #fff;
            background: #4E83FD;
          }
        }
      }
    }
  }

  @media only screen and (max-width: $device-ipad-pro) {
    .login {
      width: 100%;
      height: 100vh;

      .left-wrap {
        display: none;
      }

      .right-wrap {
        width: 100%;

        .header {
          display: flex;
          align-items: center;
          justify-content: center;
          margin-top: 20vh;

          h1 {
            font-weight: 500;
            margin-left: 15px;
          }
        }

        .login-wrap{
          width: 100%;
          height: auto;
          border-radius: 0;
          position: relative;
          box-shadow: none;

          .form {
            padding: 0px 30px;

            h3 {
              display: none;
            }
          }
        }
      }
    }
  }
</style>
