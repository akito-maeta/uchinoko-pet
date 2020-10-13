// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require bootstrap-sprockets
//= require underscore
//= require gmaps/google
//= require_tree .

//アバウト画面のロール
$(function(){
  $('#loopslider').each(function(){
    var loopsliderWidth = $(this).width();
    var loopsliderHeight = $(this).height();
    $(this).children('ul').wrapAll('<div id="loopslider_wrap"></div>');

    var listWidth = $('#loopslider_wrap').children('ul').children('li').width();
    var listCount = $('#loopslider_wrap').children('ul').children('li').length;

    var loopWidth = (listWidth)*(listCount);

    $('#loopslider_wrap').css({
      top: '0',
      left: '0',
      width: ((loopWidth) * 2),
      height: (loopsliderHeight),
      overflow: 'hidden',
      position: 'absolute'
    });

    $('#loopslider_wrap ul').css({
      width: (loopWidth)
    });
    loopsliderPosition();

    function loopsliderPosition(){
      $('#loopslider_wrap').css({left:'0'});
      $('#loopslider_wrap').stop().animate({left:'-' + (loopWidth) + 'px'},80000,'linear');
      setTimeout(function(){
          loopsliderPosition();
      },80000);
    };

    $('#loopslider_wrap ul').clone().appendTo('#loopslider_wrap');
  });
});

//user-new/user-edit画像プレビュー機能
$( document ).on('turbolinks:load', function() {
  function readfile(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('.profile-thumb').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }
  $("#pet_img").change(function(){
    $('.profile-thumb').removeClass('hidden');
    $('.default_img').remove();
    readfile(this);
  });
});


// posts-indexの選択ソート
function clickSwitch() {
  'use strict';
  var isA = 0; // 初期値
  var btnA = document.getElementById('a');
  var btnB = document.getElementById('b');
  var btnC = document.getElementById('c');
  var divA = document.getElementById('divA');
  var divB = document.getElementById('divB');
  var divC = document.getElementById('divC');

  function setState(isA) {
    btnA.className = (isA == 0) ? 'btn inactive' : 'btn'; // Aのとき非表示
    divA.className = (isA == 0) ? 'boxDisplay' : 'boxNone'; // Aのとき表示
    btnB.className = (isA == 1) ? 'btn inactive' : 'btn'; // Bのとき非表示
    divB.className = (isA == 1) ? 'boxDisplay' : 'boxNone'; // Bのとき表示
    btnC.className = (isA == 2) ? 'btn inactive' : 'btn'; // Cのとき非表示
    divC.className = (isA == 2) ? 'boxDisplay' : 'boxNone'; // Cのとき表示
  }
  setState(0);

  btnA.addEventListener('click', function(){
    if (isA == 0) return;
    isA = 0;
    setState(0);
  });
  btnB.addEventListener('click', function(){
    if (isA == 1) return;
    isA = 1;
    setState(1);
  });
  btnC.addEventListener('click', function(){
    if (isA == 2) return;
    isA = 2;
    setState(2);
  });
};
document.addEventListener("DOMContentLoaded", clickSwitch, false);


window.onpageshow = function(event) {
  if (event.persisted) {
    window.location.reload();
  }
};

  window.onpageshow = function(event) {
  if (event.persisted) {
    window.location.reload(true);
  }
};

//posts-new/posts-editの画像プレビュー
$( document ).on('turbolinks:load', function() {
  function readfile(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }
  $("#post_img").change(function(){
    $('#img_prev').removeClass('hidden');
    $('.default_img').remove();
    readfile(this);
  });
});