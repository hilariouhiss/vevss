package com.example.demo.controller;


import com.example.demo.entity.User;
import com.example.demo.service.UserService;
import com.example.demo.util.Result;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;

import java.util.Collections;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;
import static org.mockito.Mockito.times;

@SpringBootTest
@TestPropertySource(locations = "classpath:application-test.yml")
@ExtendWith(MockitoExtension.class)
public class UserControllerTests {

    @InjectMocks
    private UserController userController;

    @Mock
    private UserService userService;

    private User user;

    @BeforeEach
    public void setUp() {
        user = new User();
        user.setUsername("test");
        user.setPassword("asdfghjkl");
    }

    @Test
    public void testUpdate() {
        User updatedUser = new User();
        updatedUser.setUsername("testUpdated");
        updatedUser.setPassword("newPassword");

        when(userService.update(any(User.class))).thenReturn(updatedUser);

        User userToUpdate = new User();
        userToUpdate.setUsername("test");
        userToUpdate.setPassword("asdfghjkl");

        Result<User> result = userController.update(userToUpdate);

        assertEquals("更新成功", result.getMessage());
        assertEquals(updatedUser, result.getData());

        verify(userService, times(1)).update(any(User.class));
    }

    @Test
    public void testSelectAll() {
        when(userService.getAllUsers()).thenReturn(Collections.singletonList(user));

        Result<List<User>> result = userController.selectAll();

        assertEquals("查询成功", result.getMessage());
        assertEquals(1, result.getData().size());
        assertEquals(user, result.getData().getFirst());

        verify(userService, times(1)).getAllUsers();
    }

    @Test
    public void testSelectByUsername() {
        when(userService.getUserByUsername("test")).thenReturn(user);

        Result<User> result = userController.selectByUsername("test");

        assertEquals("查询成功", result.getMessage());
        assertEquals(user, result.getData());

        verify(userService, times(1)).getUserByUsername("test");
    }
}
