<template>
  <div class="wrapper">
    <notifications></notifications>
    <side-bar v-if="isHeader">
      <template slot="links">
        <!-- <sidebar-item
          :link="{
            name: 'Dashboard',
            path: '/dashboard',
            icon: 'ni ni-tv-2 text-primary'
          }"
        >
        </sidebar-item> -->

        <!-- <sidebar-item
          :link="{
            name: 'Icons',
            path: '/icons',
            icon: 'ni ni-planet text-blue'
          }"
        >
        </sidebar-item> -->

        <sidebar-item
          :link="{
            name: 'User Roadmap',
            path: '/godiagram',
            icon: 'ni ni-pin-3 text-orange'
          }"
        >
        </sidebar-item>

        <sidebar-item
          :link="{
            name: 'Official Roadmap',
            path: '/officialRoadmap',
            icon: 'ni ni-tv-2 text-primary'
          }"
        >
        </sidebar-item>

        <sidebar-item
          :link="{
            name: 'Profile',
            path: '/profile',
            icon: 'ni ni-single-02 text-yellow'
          }"
        >
        </sidebar-item>

        <!-- <sidebar-item
                :link="{
                  name: 'Detail Content',
                  path: '/detail-contents',
                  icon: 'ni ni-bullet-list-67 text-red'
                }">
        </sidebar-item> -->

        <!-- <sidebar-item
                  :link="{
                    name: 'Logout',
                    path: '*',
                    icon: 'ni ni-key-25 text-info'
                  }"
                  @click="logOut"
                  >
        </sidebar-item> -->

        <!-- <div class="ml-5">
          <LoginContent v-if="!getAccessToken"/>
        </div>

        <div class="ml-5">
          <LogoutContent v-if="getAccessToken"/>
        </div> -->

        <sidebar-item
                  :link="{
                    name: 'Register',
                    path: '/register',
                    icon: 'ni ni-circle-08 text-pink'
                  }"
                  v-if="!getAccessToken"
                  >
        </sidebar-item>
        
        <sidebar-item
          :link="{
            name: 'Board',
            path: '/tmp_board',
            icon: 'ni ni-bullet-list-67 text-red'
          }"
        >
        </sidebar-item>
      </template>

      <template slot="links-after">
        <hr class="my-3" />
        <h6 class="navbar-heading p-0 text-muted">Documentation</h6>

        <b-nav class="navbar-nav mb-md-3">
          <b-nav-item
            href="https://www.creative-tim.com/learning-lab/bootstrap-vue/quick-start/argon-dashboard"
          >
            <i class="ni ni-spaceship"></i>
            <b-nav-text class="p-0">Getting started</b-nav-text>
          </b-nav-item>
          <b-nav-item
            href="https://www.creative-tim.com/learning-lab/bootstrap-vue/colors/argon-dashboard"
          >
            <i class="ni ni-palette"></i>
            <b-nav-text class="p-0">Foundation</b-nav-text>
          </b-nav-item>
          <b-nav-item
            href="https://www.creative-tim.com/learning-lab/bootstrap-vue/avatar/argon-dashboard"
          >
            <i class="ni ni-ui-04"></i>
            <b-nav-text class="p-0">Components</b-nav-text>
          </b-nav-item>
        </b-nav>
      </template>
    </side-bar>
    <div class="main-content">
      <dashboard-navbar :type="$route.meta.navbarType"></dashboard-navbar>

      <div @click="$sidebar.displaySidebar(false)">
        <fade-transition :duration="200" origin="center top" mode="out-in">
          <!-- your content here -->
          <router-view></router-view>
        </fade-transition>
      </div>
      <content-footer v-if="!$route.meta.hideFooter"></content-footer>
    </div>
  </div>
</template>
<script>

  /* eslint-disable no-new */
  import PerfectScrollbar from 'perfect-scrollbar';
  import 'perfect-scrollbar/css/perfect-scrollbar.css';
  import LoginContent from '@/components/Login/LoginContent.vue';
  import LogoutContent from '@/components/Logout/LogoutContent.vue';

function hasElement(className) {
  return document.getElementsByClassName(className).length > 0;
}

function initScrollbar(className) {
  if (hasElement(className)) {
    new PerfectScrollbar(`.${className}`);
  } else {
    // try to init it later in case this component is loaded async
    setTimeout(() => {
      initScrollbar(className);
    }, 100);
  }
}

  import DashboardNavbar from './DashboardNavbar.vue';
  import ContentFooter from './ContentFooter.vue';
  import DashboardContent from './Content.vue';
  import { FadeTransition } from 'vue2-transitions';
  import { mapGetters } from 'vuex'


  export default {
    components: {
      DashboardNavbar,
      ContentFooter,
      DashboardContent,
      FadeTransition,
      LoginContent,
      LogoutContent,

    },
    created() {
      let url = this.$route.name;
      this.checkUrl(url)
    },
    
  data() {
    return {
      isHeader: true
    };
  },
  methods: {
    initScrollbar() {
      let isWindows = navigator.platform.startsWith("Win");
      if (isWindows) {
        initScrollbar("sidenav");
      }
    },
    // 특정 컴포넌트에서 nav바 제거
    checkUrl(url) {
      let array = ["roadmap"];

        let isHeader = true;
        array.map((path) => {
          if (url === path) isHeader = false;
        })
        this.isHeader = isHeader
      }
    },
    logOut() {
      this.$store.dispatch("LOGOUT").then(() => {
        this.$router.push('/')
      })
      .catch(() => {
        alert('로그아웃에 실패했습니다.')
      })
    },
    mounted() {
      this.initScrollbar()
    },
    watch: {
      $route(to) {
        this.checkUrl(to.name)
      },
    },
    computed: {
      ...mapGetters(['getAccessToken'])

    },
  };

</script>
<style lang="scss">

</style>
