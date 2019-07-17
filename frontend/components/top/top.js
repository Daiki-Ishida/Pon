import "./swiper.min.css";
import "./top.css";

import "../catch/catch";
import "../description/description";
import "../owner-steps/owner-steps";
import "../sitter-steps/sitter-steps";


import Swiper from 'swiper';

const mainSlider = new Swiper('.swiper-container',{
  direction: 'vertical',
  speed: 1000,
  mousewheel: true,
  pagination: {
    el: '.swiper-pagination',
    clickable: true,
    renderBullet: function (index, className){
      let str = '';
      switch (index){
        case 0:
          str = 'TOP'
          break;
        case 1:
          str = "PONとは？"
          break;
        case 2:
          str = '~預け方~'
          break;
        case 3:
          str = '~預かり方~'
          break;
        case 4:
          str = '早速始めよう!'
          break;
        }
        return '<span class="' + className + '">' + str + '</span>';
      }
    }
  });
