<template>
  <div>
    <b-button @click="modalShow = !modalShow" variant="primary">로그인</b-button>

    <b-modal v-model="modalShow" hide-footer centered>
      <template #modal-title class="text-center">
        <h1 class="ml-2">로그인</h1>
      </template>
      <base-input alternative
              class="mb-3"
              name="Email"
              prepend-icon="ni ni-email-83"
              placeholder="email@email.com"
              v-model="user.email"
      >
      </base-input>

      <base-input alternative
                  class="mb-3"
                  name="Password"
                  prepend-icon="ni ni-lock-circle-open"
                  type="password"
                  placeholder="Password"
                  v-model="user.password"
      >
      </base-input>
      <div class="text-center">
        <base-button type="primary" native-type="submit" class="my-4" @click="signIn">확인</base-button>
      </div>
    </b-modal>
  </div>
  <!-- <b-modal id="modal-login">
  </b-modal> -->
</template>

<script>
export default {
  data() {
    return {
      modalShow: false,
      user:{
        email: '',
        password: '',
      }
    }
  },
  methods: {
    signIn() {
      this.$store.dispatch("LOGIN", this.user).then(() => {
        this.$router.push('/dashboard')
      })
      .catch(() => {
        alert('아이디 비밀번호를 확인해주세요.')
        this.user.email = ''
        this.user.password = ''
      })
    },
  },
}
</script>

<style>

</style>