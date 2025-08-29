package com.example.intranet.controller;

public class SortFunctions {
    public static String getSortIcon(String sort, String dir, String target, String defaultSort, String defaultDir) {
        // 기본값 적용
        boolean isDefault = (sort == null || sort.isEmpty()) && target.equals(defaultSort);
        boolean match = target.equals(sort);

        if ((isDefault && defaultDir.equals("desc")) || (match && "desc".equals(dir))) {
            return "fa-arrow-down"; // 내림차순
        } else if (match && "asc".equals(dir)) {
            return "fa-arrow-up"; // 오름차순
        }
        return ""; // 정렬 중 아님
    }
}
