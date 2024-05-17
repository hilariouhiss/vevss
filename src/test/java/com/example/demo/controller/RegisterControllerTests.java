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

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@SpringBootTest(properties = {"spring.profiles.active=test"})
@TestPropertySource(locations = "classpath:application-test.yml")
@ExtendWith(MockitoExtension.class)
public class RegisterControllerTests {

    @Mock
    private UserService userService;

    @InjectMocks
    private RegisterController registerController;

    @Test
    public void testRegister() {
        User userToRegister = new User();
        userToRegister.setUsername("test");
        userToRegister.setPassword("asdfghjkl");

        Result<User> result = registerController.register(userToRegister);

        assertEquals("注册成功", result.getMessage());

        verify(userService, times(1)).register(any(User.class));
    }
}
