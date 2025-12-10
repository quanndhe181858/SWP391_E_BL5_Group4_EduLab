/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;
import java.io.*;
import java.nio.file.*;

import java.util.UUID;

/**
 *
 * @author quan
 */
public class FileUtils {

    private static final String IMAGE_DIR = "media/image";
    private static final String VIDEO_DIR = "media/video";

    private static final String[] IMAGE_EXTENSIONS = {".jpg", ".jpeg", ".png", ".gif", ".webp", ".bmp", ".jfif"};
    private static final String[] VIDEO_EXTENSIONS = {".mp4", ".avi", ".mov", ".wmv", ".flv", ".mkv", ".webm"};

    private static final long MAX_IMAGE_SIZE = 10 * 1024 * 1024; // 10MB
    private static final long MAX_VIDEO_SIZE = 100 * 1024 * 1024; // 100MB

    public static String saveFile(Part filePart, String fileType, ServletContext servletContext)
            throws IOException, IllegalArgumentException {

        if (filePart == null || filePart.getSize() == 0) {
            throw new IllegalArgumentException("File is empty or null");
        }

        String originalFileName = getFileName(filePart);
        if (originalFileName == null || originalFileName.isEmpty()) {
            throw new IllegalArgumentException("Invalid filename");
        }

        String extension = getFileExtension(originalFileName);

        validateFile(extension, filePart.getSize(), fileType);

        String uniqueFileName = generateUniqueFileName(extension);

        String targetDir = fileType.equals("image") ? IMAGE_DIR : VIDEO_DIR;
        String relativePath = targetDir + "/" + uniqueFileName;

        String buildPath = servletContext.getRealPath("/") + relativePath;
        saveToPath(filePart, buildPath);

        String sourcePath = getSourcePath(servletContext, relativePath);
        if (sourcePath != null) {
            saveToPath(filePart, sourcePath);
        }

        return relativePath;
    }

    public static String updateFile(Part filePart, String oldFilePath, String fileType, ServletContext servletContext)
            throws IOException {

        if (oldFilePath != null && !oldFilePath.isEmpty()) {
            deleteFile(oldFilePath, servletContext);
        }

        return saveFile(filePart, fileType, servletContext);
    }

    public static boolean deleteFile(String relativePath, ServletContext servletContext) {
        boolean success = true;

        try {
            String buildPath = servletContext.getRealPath("/") + relativePath;
            File buildFile = new File(buildPath);
            if (buildFile.exists()) {
                success = buildFile.delete();
            }

            String sourcePath = getSourcePath(servletContext, relativePath);
            if (sourcePath != null) {
                File sourceFile = new File(sourcePath);
                if (sourceFile.exists()) {
                    success = success && sourceFile.delete();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

        return success;
    }

    public static byte[] readFile(String relativePath, ServletContext servletContext) throws IOException {
        String fullPath = servletContext.getRealPath("/") + relativePath;
        File file = new File(fullPath);

        if (!file.exists()) {
            throw new FileNotFoundException("File not found: " + relativePath);
        }

        return Files.readAllBytes(file.toPath());
    }

    public static boolean fileExists(String relativePath, ServletContext servletContext) {
        String fullPath = servletContext.getRealPath("/") + relativePath;
        return new File(fullPath).exists();
    }

    public static long getFileSize(String relativePath, ServletContext servletContext) {
        String fullPath = servletContext.getRealPath("/") + relativePath;
        File file = new File(fullPath);
        return file.exists() ? file.length() : -1;
    }

    public static String getMimeType(String relativePath, ServletContext servletContext) {
        return servletContext.getMimeType(relativePath);
    }

    private static void saveToPath(Part filePart, String fullPath) throws IOException {
        File file = new File(fullPath);
        File parentDir = file.getParentFile();
        if (!parentDir.exists()) {
            parentDir.mkdirs();
        }

        try (InputStream input = filePart.getInputStream(); OutputStream output = new FileOutputStream(file)) {

            byte[] buffer = new byte[8192];
            int bytesRead;
            while ((bytesRead = input.read(buffer)) != -1) {
                output.write(buffer, 0, bytesRead);
            }
        }
    }

    private static String getSourcePath(ServletContext servletContext, String relativePath) {
        try {
            String buildPath = servletContext.getRealPath("/");
            if (buildPath == null) {
                return null;
            }

            File buildDir = new File(buildPath);
            File projectRoot = buildDir.getParentFile().getParentFile(); // Go up 2 levels

            String[] possibleWebDirs = {
                "src/main/webapp",
                "web",
                "WebContent"
            };

            for (String webDir : possibleWebDirs) {
                File webFolder = new File(projectRoot, webDir);
                if (webFolder.exists() && webFolder.isDirectory()) {
                    return webFolder.getAbsolutePath() + File.separator + relativePath;
                }
            }

            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private static String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition == null) {
            return null;
        }

        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                String filename = token.substring(token.indexOf("=") + 1).trim();
                return filename.replace("\"", "");
            }
        }
        return null;
    }

    private static String getFileExtension(String filename) {
        int lastDotIndex = filename.lastIndexOf(".");
        if (lastDotIndex > 0 && lastDotIndex < filename.length() - 1) {
            return filename.substring(lastDotIndex).toLowerCase();
        }
        return "";
    }

    private static String generateUniqueFileName(String extension) {
        return UUID.randomUUID().toString() + extension;
    }

    private static void validateFile(String extension, long fileSize, String fileType)
            throws IllegalArgumentException {
        boolean validExtension = false;
        if (fileType.equals("image")) {
            for (String ext : IMAGE_EXTENSIONS) {
                if (ext.equalsIgnoreCase(extension)) {
                    validExtension = true;
                    break;
                }
            }
            if (!validExtension) {
                throw new IllegalArgumentException("Invalid image format. Allowed: "
                        + String.join(", ", IMAGE_EXTENSIONS));
            }

            if (fileSize > MAX_IMAGE_SIZE) {
                throw new IllegalArgumentException("Image size exceeds maximum allowed size of "
                        + (MAX_IMAGE_SIZE / 1024 / 1024) + "MB");
            }

        } else if (fileType.equals("video")) {
            for (String ext : VIDEO_EXTENSIONS) {
                if (ext.equalsIgnoreCase(extension)) {
                    validExtension = true;
                    break;
                }
            }
            if (!validExtension) {
                throw new IllegalArgumentException("Invalid video format. Allowed: "
                        + String.join(", ", VIDEO_EXTENSIONS));
            }

            if (fileSize > MAX_VIDEO_SIZE) {
                throw new IllegalArgumentException("Video size exceeds maximum allowed size of "
                        + (MAX_VIDEO_SIZE / 1024 / 1024) + "MB");
            }
        } else {
            throw new IllegalArgumentException("Invalid file type. Must be 'image' or 'video'");
        }
    }

    public static String getFileType(String filename) {
        String extension = getFileExtension(filename);

        for (String ext : IMAGE_EXTENSIONS) {
            if (ext.equalsIgnoreCase(extension)) {
                return "image";
            }
        }

        for (String ext : VIDEO_EXTENSIONS) {
            if (ext.equalsIgnoreCase(extension)) {
                return "video";
            }
        }

        return "unknown";
    }
}
