#!/bin/bash

# 配置变量
LOCAL_PATH="C:\Users\Administrator\Desktop\PowerSport-master\数据库" # 本地项目路径
REMOTE_PATH="/home" # 远程项目路径
SSH_KEY_PATH="C:\Users\Administrator\.ssh\id_rsa" # SSH密钥路径
REMOTE_HOST="42.193.247.162" # 远程主机地址
REMOTE_PORT=22 # 远程主机SSH端口号

# 切换到本地项目目录
cd $LOCAL_PATH

# 更新代码
git pull

# 将代码部署到远程服务器
rsync -avz -e "ssh -p $REMOTE_PORT -i $SSH_KEY_PATH" --exclude-from=.rsyncignore $LOCAL_PATH/ remote_user@$REMOTE_HOST:$REMOTE_PATH/

# 重启Node.js服务
ssh -i $SSH_KEY_PATH -p $REMOTE_PORT remote_user@$REMOTE_HOST "cd $REMOTE_PATH && npm install && pm2 restart app.js"