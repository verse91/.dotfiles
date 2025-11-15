#!/usr/bin/env bash

# Chuyển tới thư mục dotfiles
cd ~/.dotfiles || {
    echo "Folder ~/.dotfiles not found"
    exit 1
}

# Thêm tất cả thay đổi
git add .

# Hỏi commit message từ người dùng
read -rp "Enter commit message: " commit_msg

# Nếu người dùng để trống, dừng script
if [[ -z "$commit_msg" ]]; then
    echo "No commit message provided. Aborting."
    exit 1
fi

# Commit với message vừa nhập
git commit -m "$commit_msg"

# Đẩy lên remote
git push
