rec_color = make_color_rgb(179, 116, 75);
draw_roundrect_colour_ext(0, 0, 50, 15, 5, 5, rec_color, rec_color, false);
draw_sprite(spr_gui_coin,1 ,7, 11);
draw_set_font(fnt_default);
draw_text(11, 0, string(coins));