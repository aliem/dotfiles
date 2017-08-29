-- Copyright 2016 xt <xt@bash.no>
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--


--[[


Emoji output/input shortcode helper for WeeChat.

Usage:
    Type :emojiname: from http://www.emoji-cheat-sheet.com/ or :partial match<tab>


    Changelog:
        version 3, 2016-11-04, xt
            * add a slack specific shortcode
        version 2, 2016-10-31, xt
            * some cleanup
            * ability replace incoming
        version 1, 2016-02-29, xt
            * initial version


EMOJI CONVERSION SCRIPT:
import json

e = json.loads(open('emoji.json').read())
print "emoji = {"
emojis = []
for k, v in e.items():
    shortname = v['shortname'].strip(':')
    ubytes = []
    cps = v['unicode'].split('-')
    for c in cps:
        ubytes.append(unichr(int(c, 16)))
    if shortname in ['end', 'repeat']:
        shortname = '["%s"]' %shortname
    elif '-' in shortname:
        shortname = '["%s"]' %shortname
    elif shortname[0].isdigit():
        shortname = '["%s"]' %shortname
    else:
        try:
            shortname = int(shortname)
            shortname = '["%s"]' %shortname
        except:
            pass
    emojis.append((shortname+'="'+u"".join(ubytes)+'",').encode('UTF-8'))
print "".join(emojis)
print "}"
--]]

local SCRIPT_NAME     = "emoji"
local SCRIPT_AUTHOR   = "xt <xt@bash.no>"
local SCRIPT_VERSION  = "3"
local SCRIPT_LICENSE  = "GPL3"
local SCRIPT_DESC     = "Emoji output helper"


-- luacheck: ignore weechat
local w = weechat
local emoji = {
four="4⃣",kiss_ww="👩❤💋👩",maple_leaf="🍁",waxing_gibbous_moon="🌔",bike="🚲",recycle="♻",family_mwgb="👨👩👧👦",flag_dk="🇩🇰",thought_balloon="💭",oncoming_automobile="🚘",guardsman_tone5="💂🏿",tickets="🎟",school="🏫",house_abandoned="🏚",blue_book="📘",video_game="🎮",triumph="😤",suspension_railway="🚟",umbrella="☔",levitate="🕴",cactus="🌵",monorail="🚝",stars="🌠",new="🆕",herb="🌿",pouting_cat="😾",blue_heart="💙",["100"]="💯",leaves="🍃",family_mwbb="👨👩👦👦",information_desk_person_tone2="💁🏼",dragon_face="🐲",track_next="⏭",cloud_snow="🌨",flag_jp="🇯🇵",children_crossing="🚸",information_desk_person_tone1="💁🏻",arrow_up_down="↕",mount_fuji="🗻",massage_tone1="💆🏻",flag_mq="🇲🇶",massage_tone3="💆🏽",massage_tone2="💆🏼",massage_tone5="💆🏿",flag_je="🇯🇪",flag_jm="🇯🇲",flag_jo="🇯🇴",red_car="🚗",hospital="🏥",red_circle="🔴",princess="👸",tm="™",curly_loop="➰",boy_tone5="👦🏿",pouch="👝",boy_tone3="👦🏽",boy_tone1="👦🏻",izakaya_lantern="🏮",fist_tone5="✊🏿",fist_tone4="✊🏾",fist_tone1="✊🏻",fist_tone3="✊🏽",fist_tone2="✊🏼",arrow_lower_left="↙",game_die="🎲",pushpin="📌",dividers="🗂",dolphin="🐬",night_with_stars="🌃",cruise_ship="🛳",white_medium_small_square="◽",kissing_closed_eyes="😚",earth_americas="🌎",["end"]="🔚",mouse="🐭",rewind="⏪",beach="🏖",pizza="🍕",briefcase="💼",customs="🛃",heartpulse="💗",sparkler="🎇",sparkles="✨",hand_splayed_tone1="🖐🏻",snowman2="☃",tulip="🌷",speaking_head="🗣",ambulance="🚑",office="🏢",clapper="🎬",keyboard="⌨",japan="🗾",post_office="🏣",dizzy_face="😵",imp="👿",flag_ve="🇻🇪",coffee="☕",flag_vg="🇻🇬",flag_va="🇻🇦",flag_vc="🇻🇨",flag_vn="🇻🇳",flag_vi="🇻🇮",open_mouth="😮",flag_vu="🇻🇺",page_with_curl="📃",bank="🏦",bread="🍞",oncoming_police_car="🚔",capricorn="♑",point_left="👈",tokyo_tower="🗼",fishing_pole_and_fish="🎣",thumbsdown="👎",telescope="🔭",spider="🕷",u7121="🈚",camera_with_flash="📸",lifter="🏋",sweet_potato="🍠",lock_with_ink_pen="🔏",ok_woman_tone2="🙆🏼",ok_woman_tone3="🙆🏽",smirk="😏",baggage_claim="🛄",cherry_blossom="🌸",sparkle="❇",zap="⚡",construction_site="🏗",dancers="👯",flower_playing_cards="🎴",hatching_chick="🐣",free="🆓",bullettrain_side="🚄",poultry_leg="🍗",grapes="🍇",smirk_cat="😼",lollipop="🍭",water_buffalo="🐃",black_medium_small_square="◾",atm="🏧",gift_heart="💝",older_woman_tone5="👵🏿",older_woman_tone4="👵🏾",older_woman_tone1="👵🏻",older_woman_tone3="👵🏽",older_woman_tone2="👵🏼",scissors="✂",woman_tone2="👩🏼",basketball="🏀",hammer_pick="⚒",top="🔝",clock630="🕡",raising_hand_tone5="🙋🏿",railway_track="🛤",nail_care="💅",crossed_flags="🎌",minibus="🚐",white_sun_cloud="🌥",shower="🚿",smile_cat="😸",dog2="🐕",loud_sound="🔊",kaaba="🕋",runner="🏃",ram="🐏",writing_hand="✍",rat="🐀",rice_scene="🎑",milky_way="🌌",vulcan_tone5="🖖🏿",necktie="👔",kissing_cat="😽",snowflake="❄",paintbrush="🖌",crystal_ball="🔮",mountain_bicyclist_tone4="🚵🏾",mountain_bicyclist_tone3="🚵🏽",mountain_bicyclist_tone2="🚵🏼",mountain_bicyclist_tone1="🚵🏻",koko="🈁",flag_it="🇮🇹",flag_iq="🇮🇶",flag_is="🇮🇸",flag_ir="🇮🇷",flag_im="🇮🇲",flag_il="🇮🇱",flag_io="🇮🇴",flag_in="🇮🇳",flag_ie="🇮🇪",flag_id="🇮🇩",flag_ic="🇮🇨",ballot_box_with_check="☑",mountain_bicyclist_tone5="🚵🏿",metal="🤘",dog="🐶",pineapple="🍍",no_good_tone3="🙅🏽",no_good_tone2="🙅🏼",no_good_tone1="🙅🏻",scream="😱",no_good_tone5="🙅🏿",no_good_tone4="🙅🏾",flag_ua="🇺🇦",bomb="💣",flag_ug="🇺🇬",flag_um="🇺🇲",flag_us="🇺🇸",construction_worker_tone1="👷🏻",radio="📻",flag_uy="🇺🇾",flag_uz="🇺🇿",person_with_blond_hair_tone1="👱🏻",cupid="💘",mens="🚹",rice="🍚",point_right_tone1="👉🏻",point_right_tone3="👉🏽",point_right_tone2="👉🏼",sunglasses="😎",point_right_tone4="👉🏾",watch="⌚",frowning="😦",watermelon="🍉",wedding="💒",person_frowning_tone4="🙍🏾",person_frowning_tone5="🙍🏿",person_frowning_tone2="🙍🏼",person_frowning_tone3="🙍🏽",person_frowning_tone1="🙍🏻",flag_gw="🇬🇼",flag_gu="🇬🇺",flag_gt="🇬🇹",flag_gs="🇬🇸",flag_gr="🇬🇷",flag_gq="🇬🇶",flag_gp="🇬🇵",flag_gy="🇬🇾",flag_gg="🇬🇬",flag_gf="🇬🇫",microscope="🔬",flag_gd="🇬🇩",flag_gb="🇬🇧",flag_ga="🇬🇦",flag_gn="🇬🇳",flag_gm="🇬🇲",flag_gl="🇬🇱",japanese_ogre="👹",flag_gi="🇬🇮",flag_gh="🇬🇭",man_with_turban="👳",star_and_crescent="☪",writing_hand_tone3="✍🏽",dromedary_camel="🐪",hash="#⃣",hammer="🔨",hourglass="⌛",postbox="📮",writing_hand_tone5="✍🏿",writing_hand_tone4="✍🏾",wc="🚾",aquarius="♒",couple_with_heart="💑",ok_woman="🙆",raised_hands_tone4="🙌🏾",cop="👮",raised_hands_tone1="🙌🏻",cow="🐮",raised_hands_tone3="🙌🏽",white_large_square="⬜",pig_nose="🐽",ice_skate="⛸",hotsprings="♨",tone5="🏿",three="3⃣",beer="🍺",stadium="🏟",airplane_departure="🛫",heavy_division_sign="➗",flag_black="🏴",mushroom="🍄",record_button="⏺",vulcan="🖖",dash="💨",wind_chime="🎐",anchor="⚓",seven="7⃣",flag_hr="🇭🇷",roller_coaster="🎢",pen_ballpoint="🖊",sushi="🍣",flag_ht="🇭🇹",flag_hu="🇭🇺",flag_hk="🇭🇰",dizzy="💫",flag_hn="🇭🇳",flag_hm="🇭🇲",arrow_forward="▶",violin="🎻",orthodox_cross="☦",id="🆔",heart_decoration="💟",first_quarter_moon="🌓",satellite="📡",tone3="🏽",christmas_tree="🎄",unicorn="🦄",broken_heart="💔",ocean="🌊",hearts="♥",snowman="⛄",person_with_blond_hair_tone4="👱🏾",person_with_blond_hair_tone5="👱🏿",person_with_blond_hair_tone2="👱🏼",person_with_blond_hair_tone3="👱🏽",yen="💴",straight_ruler="📏",sleepy="😪",green_apple="🍏",white_medium_square="◻",flag_fr="🇫🇷",grey_exclamation="❕",innocent="😇",flag_fm="🇫🇲",flag_fo="🇫🇴",flag_fi="🇫🇮",flag_fj="🇫🇯",flag_fk="🇫🇰",menorah="🕎",yin_yang="☯",clock130="🕜",gift="🎁",prayer_beads="📿",stuck_out_tongue="😛",om_symbol="🕉",city_dusk="🌆",massage_tone4="💆🏾",couple_ww="👩❤👩",crown="👑",sparkling_heart="💖",clubs="♣",person_with_pouting_face="🙎",newspaper2="🗞",fog="🌫",dango="🍡",large_orange_diamond="🔶",flag_tn="🇹🇳",flag_to="🇹🇴",point_up="☝",flag_tm="🇹🇲",flag_tj="🇹🇯",flag_tk="🇹🇰",flag_th="🇹🇭",flag_tf="🇹🇫",flag_tg="🇹🇬",corn="🌽",flag_tc="🇹🇨",flag_ta="🇹🇦",flag_tz="🇹🇿",flag_tv="🇹🇻",flag_tw="🇹🇼",flag_tt="🇹🇹",flag_tr="🇹🇷",eight_spoked_asterisk="✳",trophy="🏆",black_small_square="▪",o="⭕",no_bell="🔕",curry="🍛",alembic="⚗",sob="😭",waxing_crescent_moon="🌒",tiger2="🐅",two="2⃣",sos="🆘",compression="🗜",heavy_multiplication_x="✖",tennis="🎾",fireworks="🎆",skull_crossbones="☠",astonished="😲",congratulations="㊗",grey_question="❔",arrow_upper_left="↖",arrow_double_up="⏫",triangular_flag_on_post="🚩",gemini="♊",door="🚪",ship="🚢",point_down_tone3="👇🏽",point_down_tone4="👇🏾",point_down_tone5="👇🏿",movie_camera="🎥",ng="🆖",couple_mm="👨❤👨",football="🏈",asterisk="*⃣",taurus="♉",articulated_lorry="🚛",police_car="🚓",flushed="😳",spades="♠",cloud_lightning="🌩",wine_glass="🍷",clock830="🕣",punch_tone2="👊🏼",punch_tone3="👊🏽",punch_tone1="👊🏻",department_store="🏬",punch_tone4="👊🏾",punch_tone5="👊🏿",crocodile="🐊",white_square_button="🔳",hole="🕳",boy_tone2="👦🏼",mountain_cableway="🚠",melon="🍈",persevere="😣",trident="🔱",head_bandage="🤕",u7a7a="🈳",cool="🆒",high_brightness="🔆",deciduous_tree="🌳",white_flower="💮",gun="🔫",flag_sk="🇸🇰",flag_sj="🇸🇯",flag_si="🇸🇮",flag_sh="🇸🇭",flag_so="🇸🇴",flag_sn="🇸🇳",flag_sm="🇸🇲",flag_sl="🇸🇱",flag_sc="🇸🇨",flag_sb="🇸🇧",flag_sa="🇸🇦",flag_sg="🇸🇬",flag_tl="🇹🇱",flag_se="🇸🇪",arrow_left="⬅",flag_sz="🇸🇿",flag_sy="🇸🇾",small_orange_diamond="🔸",flag_ss="🇸🇸",flag_sr="🇸🇷",flag_sv="🇸🇻",flag_st="🇸🇹",file_folder="📁",flag_td="🇹🇩",["1234"]="🔢",smiling_imp="😈",surfer_tone2="🏄🏼",surfer_tone3="🏄🏽",surfer_tone4="🏄🏾",surfer_tone5="🏄🏿",amphora="🏺",baseball="⚾",boy="👦",flag_es="🇪🇸",raised_hands="🙌",flag_eu="🇪🇺",flag_et="🇪🇹",heavy_plus_sign="➕",bow="🙇",flag_ea="🇪🇦",flag_ec="🇪🇨",flag_ee="🇪🇪",light_rail="🚈",flag_eg="🇪🇬",flag_eh="🇪🇭",massage="💆",man_with_gua_pi_mao_tone4="👲🏾",man_with_gua_pi_mao_tone3="👲🏽",outbox_tray="📤",clock330="🕞",projector="📽",sake="🍶",confounded="😖",angry="😠",iphone="📱",sweat_smile="😅",aries="♈",ear_of_rice="🌾",mouse2="🐁",bicyclist_tone4="🚴🏾",bicyclist_tone5="🚴🏿",guardsman="💂",bicyclist_tone1="🚴🏻",bicyclist_tone2="🚴🏼",bicyclist_tone3="🚴🏽",envelope="✉",money_with_wings="💸",beers="🍻",heart_exclamation="❣",notepad_spiral="🗒",cat="🐱",running_shirt_with_sash="🎽",ferry="⛴",spy="🕵",chart_with_upwards_trend="📈",green_heart="💚",confused="😕",angel_tone4="👼🏾",scorpius="♏",sailboat="⛵",elephant="🐘",map="🗺",disappointed_relieved="😥",flag_xk="🇽🇰",motorway="🛣",sun_with_face="🌞",birthday="🎂",mag="🔍",date="📅",dove="🕊",man="👨",octopus="🐙",wheelchair="♿",truck="🚚",sa="🈂",shield="🛡",haircut="💇",last_quarter_moon_with_face="🌜",rosette="🏵",currency_exchange="💱",mailbox_with_no_mail="📭",bath="🛀",clock930="🕤",bowling="🎳",turtle="🐢",pause_button="⏸",construction_worker="👷",unlock="🔓",anger_right="🗯",beetle="🐞",girl="👧",sunrise="🌅",exclamation="❗",flag_dz="🇩🇿",family_mmgg="👨👨👧👧",factory="🏭",flag_do="🇩🇴",flag_dm="🇩🇲",flag_dj="🇩🇯",mouse_three_button="🖱",flag_dg="🇩🇬",flag_de="🇩🇪",star_of_david="✡",reminder_ribbon="🎗",grimacing="😬",thumbsup_tone3="👍🏽",thumbsup_tone2="👍🏼",thumbsup_tone1="👍🏻",musical_note="🎵",thumbsup_tone5="👍🏿",thumbsup_tone4="👍🏾",high_heel="👠",green_book="📗",headphones="🎧",flag_aw="🇦🇼",stop_button="⏹",yum="😋",flag_aq="🇦🇶",warning="⚠",cheese="🧀",ophiuchus="⛎",revolving_hearts="💞",one="1⃣",ring="💍",point_right="👉",sheep="🐑",bookmark="🔖",spider_web="🕸",eyes="👀",flag_ro="🇷🇴",flag_re="🇷🇪",flag_rs="🇷🇸",sweat_drops="💦",flag_ru="🇷🇺",flag_rw="🇷🇼",middle_finger="🖕",race_car="🏎",evergreen_tree="🌲",biohazard="☣",girl_tone3="👧🏽",scream_cat="🙀",computer="💻",hourglass_flowing_sand="⏳",flag_lb="🇱🇧",tophat="🎩",clock1230="🕧",tractor="🚜",u6709="🈶",u6708="🈷",crying_cat_face="😿",angel="👼",ant="🐜",information_desk_person="💁",anger="💢",mailbox_with_mail="📬",pencil2="✏",wink="😉",thermometer="🌡",relaxed="☺",printer="🖨",credit_card="💳",checkered_flag="🏁",family_mmg="👨👨👧",pager="📟",family_mmb="👨👨👦",radioactive="☢",fried_shrimp="🍤",link="🔗",walking="🚶",city_sunset="🌇",shopping_bags="🛍",hockey="🏒",arrow_up="⬆",gem="💎",negative_squared_cross_mark="❎",worried="😟",walking_tone5="🚶🏿",walking_tone1="🚶🏻",hear_no_evil="🙉",convenience_store="🏪",seat="💺",girl_tone1="👧🏻",cloud_rain="🌧",girl_tone2="👧🏼",girl_tone5="👧🏿",girl_tone4="👧🏾",parking="🅿",pisces="♓",calendar="📆",loudspeaker="📢",camping="🏕",bicyclist="🚴",label="🏷",diamonds="♦",older_man_tone1="👴🏻",older_man_tone3="👴🏽",older_man_tone2="👴🏼",older_man_tone5="👴🏿",older_man_tone4="👴🏾",microphone2="🎙",raising_hand="🙋",hot_pepper="🌶",guitar="🎸",tropical_drink="🍹",upside_down="🙃",restroom="🚻",pen_fountain="🖋",comet="☄",cancer="♋",jeans="👖",flag_qa="🇶🇦",boar="🐗",turkey="🦃",person_with_blond_hair="👱",oden="🍢",stuck_out_tongue_closed_eyes="😝",helicopter="🚁",control_knobs="🎛",performing_arts="🎭",tiger="🐯",foggy="🌁",sound="🔉",flag_cz="🇨🇿",flag_cy="🇨🇾",flag_cx="🇨🇽",speech_balloon="💬",seedling="🌱",flag_cr="🇨🇷",envelope_with_arrow="📩",flag_cp="🇨🇵",flag_cw="🇨🇼",flag_cv="🇨🇻",flag_cu="🇨🇺",flag_ck="🇨🇰",flag_ci="🇨🇮",flag_ch="🇨🇭",flag_co="🇨🇴",flag_cn="🇨🇳",flag_cm="🇨🇲",u5408="🈴",flag_cc="🇨🇨",flag_ca="🇨🇦",flag_cg="🇨🇬",flag_cf="🇨🇫",flag_cd="🇨🇩",purse="👛",telephone="☎",sleeping="😴",point_down_tone1="👇🏻",frowning2="☹",point_down_tone2="👇🏼",muscle_tone4="💪🏾",muscle_tone5="💪🏿",synagogue="🕍",muscle_tone1="💪🏻",muscle_tone2="💪🏼",muscle_tone3="💪🏽",clap_tone5="👏🏿",clap_tone4="👏🏾",clap_tone1="👏🏻",train2="🚆",clap_tone2="👏🏼",oil="🛢",diamond_shape_with_a_dot_inside="💠",barber="💈",metal_tone3="🤘🏽",ice_cream="🍨",rowboat_tone4="🚣🏾",burrito="🌯",metal_tone1="🤘🏻",joystick="🕹",rowboat_tone1="🚣🏻",taxi="🚕",u7533="🈸",racehorse="🐎",snowboarder="🏂",thinking="🤔",wave_tone1="👋🏻",wave_tone2="👋🏼",wave_tone3="👋🏽",wave_tone4="👋🏾",wave_tone5="👋🏿",desktop="🖥",stopwatch="⏱",pill="💊",skier="⛷",orange_book="📙",dart="🎯",disappointed="😞",grin="😁",place_of_worship="🛐",japanese_goblin="👺",arrows_counterclockwise="🔄",laughing="😆",clap="👏",left_right_arrow="↔",japanese_castle="🏯",nail_care_tone4="💅🏾",nail_care_tone5="💅🏿",nail_care_tone2="💅🏼",nail_care_tone3="💅🏽",nail_care_tone1="💅🏻",raised_hand_tone4="✋🏾",raised_hand_tone5="✋🏿",raised_hand_tone1="✋🏻",raised_hand_tone2="✋🏼",raised_hand_tone3="✋🏽",point_left_tone3="👈🏽",point_left_tone2="👈🏼",tanabata_tree="🎋",point_left_tone5="👈🏿",point_left_tone4="👈🏾",o2="🅾",knife="🔪",volcano="🌋",kissing_heart="😘",on="🔛",ok="🆗",package="📦",island="🏝",arrow_right="➡",chart_with_downwards_trend="📉",haircut_tone3="💇🏽",wolf="🐺",ox="🐂",dagger="🗡",full_moon_with_face="🌝",syringe="💉",flag_by="🇧🇾",flag_bz="🇧🇿",flag_bq="🇧🇶",flag_br="🇧🇷",flag_bs="🇧🇸",flag_bt="🇧🇹",flag_bv="🇧🇻",flag_bw="🇧🇼",flag_bh="🇧🇭",flag_bi="🇧🇮",flag_bj="🇧🇯",flag_bl="🇧🇱",flag_bm="🇧🇲",flag_bn="🇧🇳",flag_bo="🇧🇴",flag_ba="🇧🇦",flag_bb="🇧🇧",flag_bd="🇧🇩",flag_be="🇧🇪",flag_bf="🇧🇫",flag_bg="🇧🇬",satellite_orbital="🛰",radio_button="🔘",arrow_heading_down="⤵",rage="😡",whale2="🐋",vhs="📼",hand_splayed_tone3="🖐🏽",strawberry="🍓",["non-potable_water"]="🚱",hand_splayed_tone5="🖐🏿",star2="🌟",toilet="🚽",ab="🆎",cinema="🎦",floppy_disk="💾",princess_tone4="👸🏾",princess_tone5="👸🏿",princess_tone2="👸🏼",nerd="🤓",telephone_receiver="📞",princess_tone1="👸🏻",arrow_double_down="⏬",clock1030="🕥",flag_pr="🇵🇷",flag_ps="🇵🇸",poop="💩",flag_pw="🇵🇼",flag_pt="🇵🇹",flag_py="🇵🇾",pear="🍐",m="Ⓜ",flag_pa="🇵🇦",flag_pf="🇵🇫",flag_pg="🇵🇬",flag_pe="🇵🇪",flag_pk="🇵🇰",flag_ph="🇵🇭",flag_pn="🇵🇳",flag_pl="🇵🇱",flag_pm="🇵🇲",mask="😷",hushed="😯",sunrise_over_mountains="🌄",partly_sunny="⛅",dollar="💵",helmet_with_cross="⛑",smoking="🚬",no_bicycles="🚳",man_with_gua_pi_mao="👲",tv="📺",open_hands="👐",rotating_light="🚨",information_desk_person_tone4="💁🏾",information_desk_person_tone5="💁🏿",part_alternation_mark="〽",pray_tone5="🙏🏿",pray_tone4="🙏🏾",pray_tone3="🙏🏽",pray_tone2="🙏🏼",pray_tone1="🙏🏻",smile="😄",large_blue_circle="🔵",man_tone4="👨🏾",man_tone5="👨🏿",fax="📠",woman="👩",man_tone1="👨🏻",man_tone2="👨🏼",man_tone3="👨🏽",eye_in_speech_bubble="👁🗨",blowfish="🐡",card_box="🗃",ticket="🎫",ramen="🍜",twisted_rightwards_arrows="🔀",swimmer_tone4="🏊🏾",swimmer_tone5="🏊🏿",swimmer_tone1="🏊🏻",swimmer_tone2="🏊🏼",swimmer_tone3="🏊🏽",saxophone="🎷",bath_tone1="🛀🏻",notebook_with_decorative_cover="📔",bath_tone3="🛀🏽",ten="🔟",raising_hand_tone4="🙋🏾",tea="🍵",raising_hand_tone1="🙋🏻",raising_hand_tone2="🙋🏼",raising_hand_tone3="🙋🏽",zero="0⃣",ribbon="🎀",santa_tone1="🎅🏻",abc="🔤",clock="🕰",purple_heart="💜",bow_tone1="🙇🏻",no_smoking="🚭",flag_cl="🇨🇱",surfer="🏄",newspaper="📰",busstop="🚏",new_moon="🌑",traffic_light="🚥",thumbsup="👍",no_entry="⛔",name_badge="📛",classical_building="🏛",hamster="🐹",pick="⛏",two_women_holding_hands="👭",family_mmbb="👨👨👦👦",family="👪",rice_cracker="🍘",wind_blowing_face="🌬",inbox_tray="📥",tired_face="😫",carousel_horse="🎠",eye="👁",poodle="🐩",chestnut="🌰",slight_smile="🙂",mailbox_closed="📪",cloud_tornado="🌪",jack_o_lantern="🎃",lifter_tone3="🏋🏽",lifter_tone2="🏋🏼",lifter_tone1="🏋🏻",lifter_tone5="🏋🏿",lifter_tone4="🏋🏾",nine="9⃣",chocolate_bar="🍫",v="✌",man_with_turban_tone4="👳🏾",man_with_turban_tone5="👳🏿",man_with_turban_tone2="👳🏼",man_with_turban_tone3="👳🏽",man_with_turban_tone1="👳🏻",family_wwbb="👩👩👦👦",hamburger="🍔",accept="🉑",airplane="✈",dress="👗",speedboat="🚤",ledger="📒",goat="🐐",flag_ae="🇦🇪",flag_ad="🇦🇩",flag_ag="🇦🇬",flag_af="🇦🇫",flag_ac="🇦🇨",flag_am="🇦🇲",flag_al="🇦🇱",flag_ao="🇦🇴",flag_ai="🇦🇮",flag_au="🇦🇺",flag_at="🇦🇹",fork_and_knife="🍴",fast_forward="⏩",flag_as="🇦🇸",flag_ar="🇦🇷",cow2="🐄",flag_ax="🇦🇽",flag_az="🇦🇿",a="🅰",volleyball="🏐",dragon="🐉",wrench="🔧",point_up_2="👆",egg="🍳",small_red_triangle="🔺",soon="🔜",bow_tone4="🙇🏾",joy_cat="😹",pray="🙏",dark_sunglasses="🕶",rugby_football="🏉",soccer="⚽",dolls="🎎",monkey_face="🐵",clap_tone3="👏🏽",bar_chart="📊",european_castle="🏰",military_medal="🎖",frame_photo="🖼",rice_ball="🍙",trolleybus="🚎",older_woman="👵",information_source="ℹ",postal_horn="📯",house="🏠",fish="🐟",bride_with_veil="👰",fist="✊",lipstick="💄",fountain="⛲",cyclone="🌀",thumbsdown_tone2="👎🏼",thumbsdown_tone3="👎🏽",thumbsdown_tone1="👎🏻",thumbsdown_tone4="👎🏾",thumbsdown_tone5="👎🏿",cookie="🍪",heartbeat="💓",blush="😊",fire_engine="🚒",feet="🐾",horse="🐴",blossom="🌼",crossed_swords="⚔",station="🚉",clock730="🕢",banana="🍌",relieved="😌",hotel="🏨",park="🏞",aerial_tramway="🚡",flag_sd="🇸🇩",panda_face="🐼",b="🅱",flag_sx="🇸🇽",six_pointed_star="🔯",shaved_ice="🍧",chipmunk="🐿",mountain="⛰",koala="🐨",white_small_square="▫",open_hands_tone2="👐🏼",open_hands_tone3="👐🏽",u55b6="🈺",open_hands_tone1="👐🏻",open_hands_tone4="👐🏾",open_hands_tone5="👐🏿",baby_tone5="👶🏿",baby_tone4="👶🏾",baby_tone3="👶🏽",baby_tone2="👶🏼",baby_tone1="👶🏻",chart="💹",beach_umbrella="⛱",basketball_player_tone5="⛹🏿",basketball_player_tone4="⛹🏾",basketball_player_tone1="⛹🏻",basketball_player_tone3="⛹🏽",basketball_player_tone2="⛹🏼",mans_shoe="👞",shinto_shrine="⛩",ideograph_advantage="🉐",airplane_arriving="🛬",golf="⛳",minidisc="💽",hugging="🤗",crayon="🖍",point_down="👇",copyright="©",person_with_pouting_face_tone2="🙎🏼",person_with_pouting_face_tone3="🙎🏽",person_with_pouting_face_tone1="🙎🏻",person_with_pouting_face_tone4="🙎🏾",person_with_pouting_face_tone5="🙎🏿",busts_in_silhouette="👥",alarm_clock="⏰",couplekiss="💏",circus_tent="🎪",sunny="☀",incoming_envelope="📨",yellow_heart="💛",cry="😢",x="❌",arrow_up_small="🔼",art="🎨",surfer_tone1="🏄🏻",bride_with_veil_tone4="👰🏾",bride_with_veil_tone5="👰🏿",bride_with_veil_tone2="👰🏼",bride_with_veil_tone3="👰🏽",bride_with_veil_tone1="👰🏻",hibiscus="🌺",black_joker="🃏",raised_hand="✋",no_mouth="😶",basketball_player="⛹",champagne="🍾",no_entry_sign="🚫",older_man="👴",moyai="🗿",mailbox="📫",slight_frown="🙁",statue_of_liberty="🗽",mega="📣",eggplant="🍆",rose="🌹",bell="🔔",battery="🔋",wastebasket="🗑",dancer="💃",page_facing_up="📄",church="⛪",underage="🔞",secret="㊙",clock430="🕟",fork_knife_plate="🍽",u7981="🈲",fire="🔥",cold_sweat="😰",flag_er="🇪🇷",family_mwgg="👨👩👧👧",heart_eyes="😍",guardsman_tone1="💂🏻",guardsman_tone2="💂🏼",guardsman_tone3="💂🏽",guardsman_tone4="💂🏾",earth_africa="🌍",arrow_right_hook="↪",spy_tone2="🕵🏼",closed_umbrella="🌂",bikini="👙",vertical_traffic_light="🚦",kissing="😗",loop="➿",potable_water="🚰",pound="💷",["fleur-de-lis"]="⚜",key2="🗝",heavy_dollar_sign="💲",shamrock="☘",boy_tone4="👦🏾",shirt="👕",kimono="👘",left_luggage="🛅",meat_on_bone="🍖",ok_woman_tone4="🙆🏾",ok_woman_tone5="🙆🏿",arrow_heading_up="⤴",calendar_spiral="🗓",snail="🐌",ok_woman_tone1="🙆🏻",arrow_down_small="🔽",leopard="🐆",paperclips="🖇",cityscape="🏙",woman_tone1="👩🏻",slot_machine="🎰",woman_tone3="👩🏽",woman_tone4="👩🏾",woman_tone5="👩🏿",euro="💶",musical_score="🎼",triangular_ruler="📐",flags="🎏",five="5⃣",love_hotel="🏩",hotdog="🌭",speak_no_evil="🙊",eyeglasses="👓",dancer_tone4="💃🏾",dancer_tone5="💃🏿",vulcan_tone4="🖖🏾",bridge_at_night="🌉",writing_hand_tone1="✍🏻",couch="🛋",vulcan_tone1="🖖🏻",vulcan_tone2="🖖🏼",vulcan_tone3="🖖🏽",womans_hat="👒",sandal="👡",cherries="🍒",full_moon="🌕",flag_om="🇴🇲",play_pause="⏯",couple="👫",money_mouth="🤑",womans_clothes="👚",globe_with_meridians="🌐",bath_tone5="🛀🏿",bangbang="‼",stuck_out_tongue_winking_eye="😜",heart="❤",bamboo="🎍",mahjong="🀄",waning_gibbous_moon="🌖",back="🔙",point_up_2_tone4="👆🏾",point_up_2_tone5="👆🏿",lips="👄",point_up_2_tone1="👆🏻",point_up_2_tone2="👆🏼",point_up_2_tone3="👆🏽",candle="🕯",middle_finger_tone3="🖕🏽",middle_finger_tone2="🖕🏼",middle_finger_tone1="🖕🏻",middle_finger_tone5="🖕🏿",middle_finger_tone4="🖕🏾",heavy_minus_sign="➖",nose="👃",zzz="💤",stew="🍲",santa="🎅",tropical_fish="🐠",point_up_tone1="☝🏻",point_up_tone3="☝🏽",point_up_tone2="☝🏼",point_up_tone5="☝🏿",point_up_tone4="☝🏾",field_hockey="🏑",school_satchel="🎒",womens="🚺",baby_symbol="🚼",baby_chick="🐤",ok_hand_tone2="👌🏼",ok_hand_tone3="👌🏽",ok_hand_tone1="👌🏻",ok_hand_tone4="👌🏾",ok_hand_tone5="👌🏿",family_mmgb="👨👨👧👦",last_quarter_moon="🌗",tada="🎉",clock530="🕠",question="❓",registered="®",level_slider="🎚",black_circle="⚫",atom="⚛",penguin="🐧",electric_plug="🔌",skull="💀",kiss_mm="👨❤💋👨",walking_tone4="🚶🏾",fries="🍟",up="🆙",walking_tone3="🚶🏽",walking_tone2="🚶🏼",athletic_shoe="👟",hatched_chick="🐥",black_nib="✒",black_large_square="⬛",bow_and_arrow="🏹",rainbow="🌈",metal_tone5="🤘🏿",metal_tone4="🤘🏾",lemon="🍋",metal_tone2="🤘🏼",peach="🍑",peace="☮",steam_locomotive="🚂",oncoming_bus="🚍",heart_eyes_cat="😻",smiley="😃",haircut_tone1="💇🏻",haircut_tone2="💇🏼",u6e80="🈵",haircut_tone4="💇🏾",haircut_tone5="💇🏿",black_medium_square="◼",closed_book="📕",desert="🏜",expressionless="😑",dvd="📀",construction_worker_tone2="👷🏼",construction_worker_tone3="👷🏽",construction_worker_tone4="👷🏾",construction_worker_tone5="👷🏿",mag_right="🔎",bento="🍱",scroll="📜",flag_nl="🇳🇱",flag_no="🇳🇴",flag_ni="🇳🇮",european_post_office="🏤",flag_ne="🇳🇪",flag_nf="🇳🇫",flag_ng="🇳🇬",flag_na="🇳🇦",flag_nc="🇳🇨",alien="👽",first_quarter_moon_with_face="🌛",flag_nz="🇳🇿",flag_nu="🇳🇺",golfer="🏌",flag_np="🇳🇵",flag_nr="🇳🇷",anguished="😧",mosque="🕌",point_left_tone1="👈🏻",ear_tone1="👂🏻",ear_tone2="👂🏼",ear_tone3="👂🏽",ear_tone4="👂🏾",ear_tone5="👂🏿",eight_pointed_black_star="✴",wave="👋",runner_tone5="🏃🏿",runner_tone4="🏃🏾",runner_tone3="🏃🏽",runner_tone2="🏃🏼",runner_tone1="🏃🏻",railway_car="🚃",notes="🎶",no_good="🙅",trackball="🖲",spaghetti="🍝",love_letter="💌",clipboard="📋",baby_bottle="🍼",bird="🐦",card_index="📇",punch="👊",leo="♌",house_with_garden="🏡",family_wwgg="👩👩👧👧",family_wwgb="👩👩👧👦",see_no_evil="🙈",metro="🚇",popcorn="🍿",apple="🍎",scales="⚖",sleeping_accommodation="🛌",clock230="🕝",tools="🛠",cloud="☁",honey_pot="🍯",ballot_box="🗳",frog="🐸",camera="📷",crab="🦀",video_camera="📹",pencil="📝",thunder_cloud_rain="⛈",mountain_bicyclist="🚵",tangerine="🍊",train="🚋",rabbit="🐰",baby="👶",palm_tree="🌴",capital_abcd="🔠",put_litter_in_its_place="🚮",coffin="⚰",abcd="🔡",lock="🔒",pig2="🐖",family_mwg="👨👩👧",point_right_tone5="👉🏿",trumpet="🎺",film_frames="🎞",six="6⃣",leftwards_arrow_with_hook="↩",earth_asia="🌏",heavy_check_mark="✔",notebook="📓",taco="🌮",tomato="🍅",robot="🤖",mute="🔇",symbols="🔣",motorcycle="🏍",thermometer_face="🤒",paperclip="📎",moneybag="💰",neutral_face="😐",white_sun_rain_cloud="🌦",snake="🐍",kiss="💋",blue_car="🚙",confetti_ball="🎊",tram="🚊",repeat_one="🔂",smiley_cat="😺",beginner="🔰",mobile_phone_off="📴",books="📚",["8ball"]="🎱",cocktail="🍸",flag_ge="🇬🇪",horse_racing_tone2="🏇🏼",flag_mh="🇲🇭",flag_mk="🇲🇰",flag_mm="🇲🇲",flag_ml="🇲🇱",flag_mo="🇲🇴",flag_mn="🇲🇳",flag_ma="🇲🇦",flag_mc="🇲🇨",flag_me="🇲🇪",flag_md="🇲🇩",flag_mg="🇲🇬",flag_mf="🇲🇫",flag_my="🇲🇾",flag_mx="🇲🇽",flag_mz="🇲🇿",mountain_snow="🏔",flag_mp="🇲🇵",flag_ms="🇲🇸",flag_mr="🇲🇷",flag_mu="🇲🇺",flag_mt="🇲🇹",flag_mw="🇲🇼",flag_mv="🇲🇻",timer="⏲",passport_control="🛂",small_blue_diamond="🔹",lion_face="🦁",white_check_mark="✅",bouquet="💐",track_previous="⏮",monkey="🐒",tone4="🏾",closed_lock_with_key="🔐",family_wwb="👩👩👦",family_wwg="👩👩👧",tone1="🏻",crescent_moon="🌙",shell="🐚",gear="⚙",tone2="🏼",small_red_triangle_down="🔻",nut_and_bolt="🔩",umbrella2="☂",unamused="😒",fuelpump="⛽",bed="🛏",bee="🐝",round_pushpin="📍",flag_white="🏳",microphone="🎤",bus="🚌",eight="8⃣",handbag="👜",medal="🏅",arrows_clockwise="🔃",urn="⚱",bookmark_tabs="📑",new_moon_with_face="🌚",fallen_leaf="🍂",horse_racing="🏇",chicken="🐔",ear="👂",wheel_of_dharma="☸",arrow_lower_right="↘",man_with_gua_pi_mao_tone5="👲🏿",scorpion="🦂",waning_crescent_moon="🌘",man_with_gua_pi_mao_tone2="👲🏼",man_with_gua_pi_mao_tone1="👲🏻",bug="🐛",virgo="♍",libra="♎",angel_tone1="👼🏻",angel_tone3="👼🏽",angel_tone2="👼🏼",angel_tone5="👼🏿",sagittarius="♐",bear="🐻",information_desk_person_tone3="💁🏽",no_mobile_phones="📵",hand_splayed="🖐",motorboat="🛥",calling="📲",interrobang="⁉",oncoming_taxi="🚖",flag_lt="🇱🇹",flag_lu="🇱🇺",flag_lr="🇱🇷",flag_ls="🇱🇸",flag_ly="🇱🇾",bellhop="🛎",arrow_down="⬇",flag_lc="🇱🇨",flag_la="🇱🇦",flag_lk="🇱🇰",flag_li="🇱🇮",ferris_wheel="🎡",hand_splayed_tone2="🖐🏼",large_blue_diamond="🔷",cat2="🐈",icecream="🍦",tent="⛺",joy="😂",hand_splayed_tone4="🖐🏾",file_cabinet="🗄",key="🔑",weary="😩",bath_tone2="🛀🏼",flag_lv="🇱🇻",low_brightness="🔅",rowboat_tone5="🚣🏿",rowboat_tone2="🚣🏼",rowboat_tone3="🚣🏽",four_leaf_clover="🍀",space_invader="👾",cl="🆑",cd="💿",bath_tone4="🛀🏾",flag_za="🇿🇦",swimmer="🏊",wavy_dash="〰",flag_zm="🇿🇲",flag_zw="🇿🇼",raised_hands_tone5="🙌🏿",two_hearts="💕",bulb="💡",cop_tone4="👮🏾",cop_tone5="👮🏿",cop_tone2="👮🏼",cop_tone3="👮🏽",cop_tone1="👮🏻",open_file_folder="📂",homes="🏘",raised_hands_tone2="🙌🏼",fearful="😨",grinning="😀",bow_tone5="🙇🏿",santa_tone3="🎅🏽",santa_tone2="🎅🏼",santa_tone5="🎅🏿",santa_tone4="🎅🏾",bow_tone2="🙇🏼",bow_tone3="🙇🏽",bathtub="🛁",ping_pong="🏓",u5272="🈹",rooster="🐓",vs="🆚",bullettrain_front="🚅",airplane_small="🛩",white_circle="⚪",balloon="🎈",cross="✝",princess_tone3="👸🏽",speaker="🔈",zipper_mouth="🤐",u6307="🈯",whale="🐳",pensive="😔",signal_strength="📶",muscle="💪",rocket="🚀",camel="🐫",boot="👢",flashlight="🔦",spy_tone4="🕵🏾",spy_tone5="🕵🏿",ski="🎿",spy_tone3="🕵🏽",musical_keyboard="🎹",spy_tone1="🕵🏻",rolling_eyes="🙄",clock1="🕐",clock2="🕑",clock3="🕒",clock4="🕓",clock5="🕔",clock6="🕕",clock7="🕖",clock8="🕗",clock9="🕘",doughnut="🍩",dancer_tone1="💃🏻",dancer_tone2="💃🏼",dancer_tone3="💃🏽",candy="🍬",two_men_holding_hands="👬",badminton="🏸",bust_in_silhouette="👤",writing_hand_tone2="✍🏼",sunflower="🌻",["e-mail"]="📧",chains="⛓",kissing_smiling_eyes="😙",fish_cake="🍥",no_pedestrians="🚷",v_tone4="✌🏾",v_tone5="✌🏿",v_tone1="✌🏻",v_tone2="✌🏼",v_tone3="✌🏽",arrow_backward="◀",clock12="🕛",clock10="🕙",clock11="🕚",sweat="😓",mountain_railway="🚞",tongue="👅",black_square_button="🔲",do_not_litter="🚯",nose_tone4="👃🏾",nose_tone5="👃🏿",nose_tone2="👃🏼",nose_tone3="👃🏽",nose_tone1="👃🏻",horse_racing_tone5="🏇🏿",horse_racing_tone4="🏇🏾",horse_racing_tone3="🏇🏽",ok_hand="👌",horse_racing_tone1="🏇🏻",custard="🍮",rowboat="🚣",white_sun_small_cloud="🌤",flag_kr="🇰🇷",cricket="🏏",flag_kp="🇰🇵",flag_kw="🇰🇼",flag_kz="🇰🇿",flag_ky="🇰🇾",construction="🚧",flag_kg="🇰🇬",flag_ke="🇰🇪",flag_ki="🇰🇮",flag_kh="🇰🇭",flag_kn="🇰🇳",flag_km="🇰🇲",cake="🍰",flag_wf="🇼🇫",mortar_board="🎓",pig="🐷",flag_ws="🇼🇸",person_frowning="🙍",arrow_upper_right="↗",book="📖",clock1130="🕦",boom="💥",["repeat"]="🔁",star="⭐",rabbit2="🐇",footprints="👣",ghost="👻",droplet="💧",vibration_mode="📳",flag_ye="🇾🇪",flag_yt="🇾🇹",
}
emoji['slightly_smiling_face'] = ':)'

local function str2emoji(str)
	if not str then return '' end
	return (str:gsub(':[a-zA-Z0-9%-_]+:', function(word)
		return emoji[word:match(':(.+):')] or word
	end))
end

function emoji_replace_input_string(buffer)
	-- Get input contents
	local input_s = w.buffer_get_string(buffer, 'input')
	-- Skip modification of settings
	if input_s:match('^/set ') then
		return w.WEECHAT_RC_OK
	end
	w.buffer_set(buffer, 'input', str2emoji(input_s))
	return w.WEECHAT_RC_OK
end

function emoji_input_replacer(data, buffer, command)
	if command == '/input return' then
		return emoji_replace_input_string(buffer)
	end
	return w.WEECHAT_RC_OK
end

function emoji_live_input_replace(data, modifier, modifier_data, msg)
	return str2emoji(msg)
end

function emoji_out_replace(data, modifier, modifier_data, msg)
	return str2emoji(msg)
end

function unshortcode_cb(data, modifier, modifier_data, msg)
	return str2emoji(msg)
end

function emoji_complete_next_cb(data, buffer, command)
	local input_s = w.buffer_get_string(buffer, 'input')
	-- Require : in word
	if not input_s:match(':') then
		return w.WEECHAT_RC_OK
	end
	local current_pos = w.buffer_get_integer(buffer, "input_pos") - 1
	--local input_length = w.buffer_get_integer(buffer, "input_length")
	while current_pos >= 1 and input_s.sub(current_pos, current_pos) ~= ':' do
		current_pos = current_pos - 1
	end
	if current_pos < 1 then
		current_pos = 1
	end

	-- TODO: Support non-end-word editing
	local oword = input_s:sub(current_pos)
	local word = oword:match(':(.*)')
	for e, b in pairs(emoji) do
		if e:match(word) then
			local new = (input_s:gsub(":"..word, b))
			w.buffer_set(buffer, 'input', new)
			--w.buffer_set(buffer, "input_pos", str(w.buffer_get_integer(buffer, "input_pos") + 1))
			return w.WEECHAT_RC_OK_EAT
		end
	end

	return w.WEECHAT_RC_OK
end

function emoji_completion_cb(data, completion_item, buffer, completion)
	for k, v in pairs(emoji) do
		w.hook_completion_list_add(completion, ":"..k..":", 0, w.WEECHAT_LIST_POS_SORT)
	end
	return w.WEECHAT_RC_OK
end

function incoming_cb(data, modifier, modifier_data, msg)
	--local plugin, buffer_name, tags = modifier_data:match('^(.-);(.-);(.-)$')
	-- Only replace in incoming "messages"
	if modifier_data:match('nick_') then
		return str2emoji(msg)
	end
	return msg
end

function e_init()
	if w.register(
		SCRIPT_NAME,
		SCRIPT_AUTHOR,
		SCRIPT_VERSION,
		SCRIPT_LICENSE,
		SCRIPT_DESC,
		'',
		'') then
		-- Hook input enter
		w.hook_command_run('/input return', 'emoji_input_replacer', '')

		-- Hook irc out for relay clients
		--w.hook_modifier('input_text_for_buffer', 'emoji_out_replace', '')
		w.hook_modifier('irc_out1_PRIVMSG', 'emoji_out_replace', '')
		-- Replace while typing
		w.hook_modifier('input_text_display_with_cursor', 'emoji_live_input_replace', '')
		-- Hook tab complete
		w.hook_command_run("/input complete_next", "emoji_complete_next_cb", "")
		-- Hook for working togheter with other scripts
		w.hook_modifier('emoji_unshortcode', 'unshortcode_cb', '')

		w.hook_completion("emojis", "complete :emoji:s", "emoji_completion_cb", "")
		local settings = {
		    incoming = {'on', 'Also try to replace shortcodes to emoji in incoming messages'}
		}
		-- set default settings
		local version = tonumber(w.info_get('version_number', '') or 0)
		for option, value in pairs(settings) do
			if w.config_is_set_plugin(option) ~= 1 then
				w.config_set_plugin(option, value[1])
			end
			if version >= 0x00030500 then
				w.config_set_desc_plugin(option, ('%s (default: "%s")'):format(
				value[2], value[1]))
			end
		end
		-- Hook incoming message
		if w.config_get_plugin('incoming') == 'on' then
			w.hook_modifier("weechat_print", 'incoming_cb', '')
		end
	end
end

e_init()
