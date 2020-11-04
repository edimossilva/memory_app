<template>
  <div></div>
</template>

<script>
export default {
  name: "OmniauthCallback",
  mounted() {
    const token = this.$route.query.token;
    if (token) {
      localStorage.token = token;
      this.$router.push({ name: "Home" });
    } else {
      console.error("token not received :(");
    }
  },
};
</script>

<style></style>
