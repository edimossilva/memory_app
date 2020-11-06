
export const HOST =
  process.env.VUE_APP_API_URL || "https://memory-app-back.herokuapp.com";


export const getRequestConfig = () => {
  const token = localStorage.getItem("token");
  const requestConfig = {
    headers: {
      Authorization: `Basic ${token}`,
    },
  };

  return requestConfig;
};

