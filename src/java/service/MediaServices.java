/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dao.MediaDAO;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Media;

/**
 *
 * @author quan
 */
public class MediaServices {

    private final Logger logger = Logger.getLogger(this.getClass().getName());
    private final MediaDAO mDao = new MediaDAO();

    public Media createMedia(Media m, int uid) {
        try {
            return mDao.createMedia(m, uid);
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            return null;
        }
    }

    public Media getMediaByIdAndType(String type, int objectId) {
        try {
            return mDao.getMediaByIdAndType(type, objectId);
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            return null;
        }
    }

    public boolean deleteMedia(int id) {
        try {
            return mDao.deleteMedia(id);
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            return false;
        }
    }

    public boolean updateMedia(Media m, int uid) {
        try {
            return mDao.updateMedia(m);
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            return false;
        }
    }
}
