package com.simplecoding.cheforest.board.repository;
import com.simplecoding.cheforest.board.entity.Board;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BoardRepository extends JpaRepository<Board, Long> {
}
