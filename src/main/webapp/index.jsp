<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Mind Circuit Flow</title>
  <style>
    body,html {
      margin:0; padding:0; height:100%; width:100%;
      font-family: Arial, sans-serif;
      background:#111; color:#fff;
    }
    .screen { display:none; height:100%; width:100%; }
    .center { display:flex; flex-direction:column; align-items:center; justify-content:center; height:100%; gap:20px; }
    button {
      padding:10px 20px; font-size:16px; border:none;
      border-radius:6px; cursor:pointer; background:#4CAF50; color:white;
    }
    #finalPage {
      position:relative; overflow:hidden;
      background:black; height:100%; width:100%;
    }
    #finalMsg {
      position:absolute; top:40%; left:50%;
      transform:translate(-50%,-50%);
      font-size:32px; font-weight:bold; color:#00e5ff;
      text-align:center; z-index:10;
      text-shadow:0 0 10px #0ff,0 0 20px #0ff;
    }
    canvas { position:absolute; top:0; left:0; width:100%; height:100%; z-index:0; }
  </style>
</head>
<body>

  <!-- Step 1 -->
  <div id="screen1" class="screen center" style="display:flex">
    <h1>Welcome to Naga Babu</h1>
    <button onclick="goToLogin()">Open</button>
  </div>

  <!-- Step 2 -->
  <div id="screen2" class="screen center">
    <h2>Login</h2>
    <form onsubmit="return goToFinal()">
      <input type="text" placeholder="Username" required><br>
      <input type="password" placeholder="Password" required><br>
      <button type="submit">Sign In</button>
    </form>
  </div>

  <!-- Step 3 -->
  <div id="finalPage" class="screen">
    <canvas id="fireCanvas"></canvas>
    <div id="finalMsg">🎉 Welcome to Mind Circuit Institute 🎉</div>
  </div>

<script>
  function goToLogin(){
    document.getElementById("screen1").style.display="none";
    document.getElementById("screen2").style.display="flex";
  }

  function goToFinal(){
    document.getElementById("screen2").style.display="none";
    document.getElementById("finalPage").style.display="block";
    startFireworks();
    return false; // prevent form reload
  }

  function startFireworks(){
    const canvas=document.getElementById("fireCanvas");
    const ctx=canvas.getContext("2d");
    let w,h;
    function resize(){
      w=canvas.width=window.innerWidth;
      h=canvas.height=window.innerHeight;
    }
    window.onresize=resize; resize();

    const particles=[];

    function random(min,max){ return Math.random()*(max-min)+min; }

    function Firework(x,y,color){
      this.x=x; this.y=y; this.color=color;
      this.life=100;
      this.vx=random(-3,3); this.vy=random(-7,-3);
    }
    Firework.prototype.update=function(){
      this.x+=this.vx; this.y+=this.vy;
      this.vy+=0.2; this.life--;
    }
    Firework.prototype.draw=function(){
      ctx.beginPath();
      ctx.arc(this.x,this.y,2,0,Math.PI*2);
      ctx.fillStyle=this.color;
      ctx.fill();
    }

    function loop(){
      ctx.fillStyle="rgba(0,0,0,0.2)";
      ctx.fillRect(0,0,w,h);
      if(Math.random()<0.08){
        for(let i=0;i<50;i++){
          particles.push(new Firework(random(0,w),h,`hsl(${Math.random()*360},100%,60%)`));
        }
      }
      for(let i=particles.length-1;i>=0;i--){
        let p=particles[i];
        p.update(); p.draw();
        if(p.life<=0) particles.splice(i,1);
      }
      requestAnimationFrame(loop);
    }
    loop();
  }
</script>
</body>
</html>

