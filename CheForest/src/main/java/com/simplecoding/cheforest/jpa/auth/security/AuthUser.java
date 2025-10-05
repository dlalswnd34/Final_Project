package com.simplecoding.cheforest.jpa.auth.security;

import com.simplecoding.cheforest.jpa.auth.entity.Member;

public interface AuthUser {
    Member getMember();
}