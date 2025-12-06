/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import com.google.cloud.storage.*;
import java.io.IOException;
import java.net.URL;
import java.util.concurrent.TimeUnit;

/**
 *
 * @author quan
 */
public class GoogleCloudService {

    private final Storage storage;
    private final String bucketName;

    public GoogleCloudService(String bucketName) {
        this.storage = StorageOptions.getDefaultInstance().getService();
        this.bucketName = bucketName;
    }

    public String upload(byte[] data, String folder, String originalFileName, String mimeType) throws IOException {
        // Generate safe unique name
        String ext = "";
        int i = originalFileName.lastIndexOf('.');
        if (i >= 0) {
            ext = originalFileName.substring(i);
        }
        String storedName = java.util.UUID.randomUUID().toString() + ext;

        String objectName = folder + "/" + storedName;

        BlobId blobId = BlobId.of(bucketName, objectName);
        BlobInfo blobInfo = BlobInfo.newBuilder(blobId)
                .setContentType(mimeType)
                .build();

        storage.create(blobInfo, data);
        return storedName;
    }

    public String getPublicUrl(String folder, String storedFileName) {
        return "https://storage.googleapis.com/" + bucketName + "/" + folder + "/" + storedFileName;
    }

    public String getSignedUrl(String folder, String storedFileName, long duration, TimeUnit unit) {
        BlobInfo blobInfo = BlobInfo.newBuilder(
                BlobId.of(bucketName, folder + "/" + storedFileName)
        ).build();

        URL url = storage.signUrl(
                blobInfo,
                duration,
                unit,
                Storage.SignUrlOption.withV4Signature()
        );

        return url.toString();
    }

    public byte[] download(String folder, String storedFileName) {
        Blob blob = storage.get(BlobId.of(bucketName, folder + "/" + storedFileName));
        if (blob == null) {
            return null;
        }
        return blob.getContent();
    }

    public boolean delete(String folder, String storedFileName) {
        return storage.delete(BlobId.of(bucketName, folder + "/" + storedFileName));
    }

}
