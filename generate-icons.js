// 生成猫咪日记应用图标
// 运行方式：node generate-icons.js

const { createCanvas, loadImage } = require('canvas');
const fs = require('fs');
const path = require('path');

const iconDir = path.join(__dirname, 'icons');
if (!fs.existsSync(iconDir)) {
  fs.mkdirSync(iconDir, { recursive: true });
}

const sizes = [72, 96, 128, 144, 152, 192, 384, 512];

function drawIcon(size) {
  const canvas = createCanvas(size, size);
  const ctx = canvas.getContext('2d');
  
  const s = size;
  const scale = s / 512;
  
  // 背景渐变
  const gradient = ctx.createLinearGradient(0, 0, s, s);
  gradient.addColorStop(0, '#FFB6A3');
  gradient.addColorStop(0.5, '#FF9A8B');
  gradient.addColorStop(1, '#FF6B6B');
  
  // 圆角背景
  const radius = 90 * scale;
  ctx.beginPath();
  ctx.moveTo(radius, 0);
  ctx.lineTo(s - radius, 0);
  ctx.quadraticCurveTo(s, 0, s, radius);
  ctx.lineTo(s, s - radius);
  ctx.quadraticCurveTo(s, s, s - radius, s);
  ctx.lineTo(radius, s);
  ctx.quadraticCurveTo(0, s, 0, s - radius);
  ctx.lineTo(0, radius);
  ctx.quadraticCurveTo(0, 0, radius, 0);
  ctx.closePath();
  ctx.fillStyle = gradient;
  ctx.fill();
  
  // 猫咪脸 - 脸的轮廓
  const cx = s / 2;
  const cy = s / 2 + 10 * scale;
  const faceW = 280 * scale;
  const faceH = 240 * scale;
  
  // 左耳
  ctx.beginPath();
  ctx.moveTo(cx - 100 * scale, cy - 60 * scale);
  ctx.lineTo(cx - 140 * scale, cy - 160 * scale);
  ctx.lineTo(cx - 40 * scale, cy - 100 * scale);
  ctx.closePath();
  ctx.fillStyle = '#FFE4DC';
  ctx.fill();
  
  // 右耳
  ctx.beginPath();
  ctx.moveTo(cx + 100 * scale, cy - 60 * scale);
  ctx.lineTo(cx + 140 * scale, cy - 160 * scale);
  ctx.lineTo(cx + 40 * scale, cy - 100 * scale);
  ctx.closePath();
  ctx.fillStyle = '#FFE4DC';
  ctx.fill();
  
  // 左耳内侧
  ctx.beginPath();
  ctx.moveTo(cx - 95 * scale, cy - 75 * scale);
  ctx.lineTo(cx - 125 * scale, cy - 140 * scale);
  ctx.lineTo(cx - 55 * scale, cy - 100 * scale);
  ctx.closePath();
  ctx.fillStyle = '#FFB5B5';
  ctx.fill();
  
  // 右耳内侧
  ctx.beginPath();
  ctx.moveTo(cx + 95 * scale, cy - 75 * scale);
  ctx.lineTo(cx + 125 * scale, cy - 140 * scale);
  ctx.lineTo(cx + 55 * scale, cy - 100 * scale);
  ctx.closePath();
  ctx.fillStyle = '#FFB5B5';
  ctx.fill();
  
  // 脸部
  ctx.beginPath();
  ctx.ellipse(cx, cy, faceW / 2, faceH / 2, 0, 0, Math.PI * 2);
  ctx.fillStyle = '#FFE4DC';
  ctx.fill();
  
  // 眼睛
  const eyeY = cy - 10 * scale;
  const eyeSpacing = 70 * scale;
  const eyeW = 28 * scale;
  const eyeH = 36 * scale;
  
  // 左眼
  ctx.beginPath();
  ctx.ellipse(cx - eyeSpacing, eyeY, eyeW, eyeH, 0, 0, Math.PI * 2);
  ctx.fillStyle = '#3D3D3D';
  ctx.fill();
  
  // 右眼
  ctx.beginPath();
  ctx.ellipse(cx + eyeSpacing, eyeY, eyeW, eyeH, 0, 0, Math.PI * 2);
  ctx.fillStyle = '#3D3D3D';
  ctx.fill();
  
  // 眼睛高光
  ctx.beginPath();
  ctx.ellipse(cx - eyeSpacing + 8 * scale, eyeY - 10 * scale, 8 * scale, 10 * scale, 0, 0, Math.PI * 2);
  ctx.fillStyle = 'white';
  ctx.fill();
  
  ctx.beginPath();
  ctx.ellipse(cx + eyeSpacing + 8 * scale, eyeY - 10 * scale, 8 * scale, 10 * scale, 0, 0, Math.PI * 2);
  ctx.fillStyle = 'white';
  ctx.fill();
  
  // 鼻子
  ctx.beginPath();
  ctx.moveTo(cx, cy + 20 * scale);
  ctx.lineTo(cx - 15 * scale, cy + 5 * scale);
  ctx.lineTo(cx + 15 * scale, cy + 5 * scale);
  ctx.closePath();
  ctx.fillStyle = '#FF9A8B';
  ctx.fill();
  
  // 嘴巴
  ctx.beginPath();
  ctx.moveTo(cx, cy + 20 * scale);
  ctx.quadraticCurveTo(cx - 20 * scale, cy + 40 * scale, cx - 30 * scale, cy + 30 * scale);
  ctx.strokeStyle = '#3D3D3D';
  ctx.lineWidth = 4 * scale;
  ctx.lineCap = 'round';
  ctx.stroke();
  
  ctx.beginPath();
  ctx.moveTo(cx, cy + 20 * scale);
  ctx.quadraticCurveTo(cx + 20 * scale, cy + 40 * scale, cx + 30 * scale, cy + 30 * scale);
  ctx.strokeStyle = '#3D3D3D';
  ctx.lineWidth = 4 * scale;
  ctx.lineCap = 'round';
  ctx.stroke();
  
  // 胡须
  ctx.strokeStyle = 'rgba(61, 61, 61, 0.5)';
  ctx.lineWidth = 2 * scale;
  ctx.lineCap = 'round';
  
  // 左边胡须
  ctx.beginPath();
  ctx.moveTo(cx - 80 * scale, cy + 20 * scale);
  ctx.lineTo(cx - 160 * scale, cy + 10 * scale);
  ctx.stroke();
  
  ctx.beginPath();
  ctx.moveTo(cx - 80 * scale, cy + 30 * scale);
  ctx.lineTo(cx - 160 * scale, cy + 35 * scale);
  ctx.stroke();
  
  ctx.beginPath();
  ctx.moveTo(cx - 80 * scale, cy + 40 * scale);
  ctx.lineTo(cx - 150 * scale, cy + 55 * scale);
  ctx.stroke();
  
  // 右边胡须
  ctx.beginPath();
  ctx.moveTo(cx + 80 * scale, cy + 20 * scale);
  ctx.lineTo(cx + 160 * scale, cy + 10 * scale);
  ctx.stroke();
  
  ctx.beginPath();
  ctx.moveTo(cx + 80 * scale, cy + 30 * scale);
  ctx.lineTo(cx + 160 * scale, cy + 35 * scale);
  ctx.stroke();
  
  ctx.beginPath();
  ctx.moveTo(cx + 80 * scale, cy + 40 * scale);
  ctx.lineTo(cx + 150 * scale, cy + 55 * scale);
  ctx.stroke();
  
  // 腮红
  ctx.fillStyle = 'rgba(255, 154, 139, 0.4)';
  ctx.beginPath();
  ctx.ellipse(cx - 90 * scale, cy + 35 * scale, 25 * scale, 15 * scale, 0, 0, Math.PI * 2);
  ctx.fill();
  
  ctx.beginPath();
  ctx.ellipse(cx + 90 * scale, cy + 35 * scale, 25 * scale, 15 * scale, 0, 0, Math.PI * 2);
  ctx.fill();
  
  // 爪印装饰
  const pawX = s - 80 * scale;
  const pawY = s - 70 * scale;
  
  ctx.fillStyle = 'rgba(255, 255, 255, 0.3)';
  
  // 掌垫
  ctx.beginPath();
  ctx.ellipse(pawX, pawY, 20 * scale, 16 * scale, 0, 0, Math.PI * 2);
  ctx.fill();
  
  // 趾垫
  ctx.beginPath();
  ctx.ellipse(pawX - 22 * scale, pawY - 18 * scale, 8 * scale, 10 * scale, -0.3, 0, Math.PI * 2);
  ctx.fill();
  
  ctx.beginPath();
  ctx.ellipse(pawX - 8 * scale, pawY - 24 * scale, 8 * scale, 10 * scale, -0.1, 0, Math.PI * 2);
  ctx.fill();
  
  ctx.beginPath();
  ctx.ellipse(pawX + 8 * scale, pawY - 24 * scale, 8 * scale, 10 * scale, 0.1, 0, Math.PI * 2);
  ctx.fill();
  
  ctx.beginPath();
  ctx.ellipse(pawX + 22 * scale, pawY - 18 * scale, 8 * scale, 10 * scale, 0.3, 0, Math.PI * 2);
  ctx.fill();
  
  return canvas;
}

sizes.forEach(size => {
  const canvas = drawIcon(size);
  const buffer = canvas.toBuffer('image/png');
  const filePath = path.join(iconDir, `icon-${size}.png`);
  fs.writeFileSync(filePath, buffer);
  console.log(`✓ 生成图标: ${size}x${size}`);
});

console.log('\n🎉 所有图标生成完成！位置: icons/ 文件夹');
