const MILISECONDS = 1200;

export const successNotify = (buefy, message) => {
  buefy.notification.open({
    message,
    type: "is-success",
    position: "is-top",
    duration: MILISECONDS,
  });
};

export const infoNotify = (buefy, message) => {
  buefy.notification.open({
    message,
    type: "is-info",
    position: "is-top",
    duration: MILISECONDS,
  });
};

export const dangerNotify = (buefy, message) => {
  buefy.notification.open({
    message,
    type: "is-danger",
    position: "is-top",
    duration: MILISECONDS,
  });
};
