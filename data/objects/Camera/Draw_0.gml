draw_clear(c_black);

// You can set the camera projection(s) at any point
var camera = camera_get_active();
camera_set_view_mat(camera, matrix_build_lookat(x, y, z, x + dcos(direction) * dcos(pitch), y - dsin(direction) * dcos(pitch), z + dsin(pitch), 0, 0, 1));
camera_set_proj_mat(camera, matrix_build_projection_perspective_fov(-60, -window_get_width() / window_get_height(), 1, 32000));
camera_apply(camera);

// Anything drawn has to be drawn after the camera projections are set
with (GameObject) event_perform(ev_draw, 0);