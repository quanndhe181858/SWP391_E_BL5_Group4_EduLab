/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 *
 * @author hao
 */
public class RandomUtils {

    private static final String LOWER = "abcdefghijklmnopqrstuvwxyz";
    private static final String UPPER = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private static final String DIGIT = "0123456789";
    private static final String SPECIAL = "!@#$%^&*()-_=+[]{}|;:,.<>?";

    private static final SecureRandom random = new SecureRandom();

    public static String getRandomString(int length) {
        if (length < 4) {
            throw new IllegalArgumentException("Length must be at least 8");
        }

        List<Character> chars = new ArrayList<>();

        chars.add(LOWER.charAt(random.nextInt(LOWER.length())));
        chars.add(UPPER.charAt(random.nextInt(UPPER.length())));
        chars.add(DIGIT.charAt(random.nextInt(DIGIT.length())));
        chars.add(SPECIAL.charAt(random.nextInt(SPECIAL.length())));

        String allChars = LOWER + UPPER + DIGIT + SPECIAL;

        for (int i = 4; i < length; i++) {
            chars.add(allChars.charAt(random.nextInt(allChars.length())));
        }

        Collections.shuffle(chars, random);

        StringBuilder result = new StringBuilder();
        for (char c : chars) {
            result.append(c);
        }

        return result.toString();
    }

}
