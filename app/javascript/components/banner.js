import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#vhs-title', {
    strings: ["FIND FEEDBACKS YOU LOVE", "AND POST YOURS..."],
    typeSpeed: 80,
    loop: true
  });
}

export { loadDynamicBannerText };
