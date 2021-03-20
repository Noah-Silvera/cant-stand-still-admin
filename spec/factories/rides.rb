FactoryBot.define do
  sequence(:activity_id_seq, 0)

  factory :ride do
    transient do
      activity_id_seq { generate(:activity_id_seq) }
    end

    rider
    start_date { Time.zone.now }
    activity_id { activity_id_seq }
    activity_json {
      {
        "resource_state": 2,
        "athlete": {
          "id": 22140740,
          "resource_state": 1
        },
        "name": "we saw a dog with sunglasses in a motorcyle side car, baby sheep and goats. 12/10 ride exceeded expectations.",
        "distance": 99907.6,
        "moving_time": 15664,
        "elapsed_time": 17178,
        "total_elevation_gain": 1517.2,
        "type": "Ride",
        "workout_type": 10,
        "id": activity_id_seq,
        "external_id": "17BCDBDC-E362-4F47-8490-466DE32B3D96-activity.fit",
        "upload_id": 4954712482,
        "start_date": "2021-01-17T20:12:10Z",
        "start_date_local": "2021-01-17T12:12:10Z",
        "timezone": "(GMT-08:00) America/Vancouver",
        "utc_offset": -28800.0,
        "start_latlng": [
          48.45,
          -123.38
        ],
        "end_latlng": [
          48.45,
          -123.38
        ],
        "location_city": nil,
        "location_state": nil,
        "location_country": nil,
        "start_latitude": 48.45,
        "start_longitude": -123.38,
        "achievement_count": 29,
        "kudos_count": 19,
        "comment_count": 2,
        "athlete_count": 2,
        "photo_count": 0,
        "map": {
          "id": "a4639259290",
          "summary_polyline": "inufHt_apVjDaLyAyBqBcY_FSkl@fRjApNoN`bAIph@sEj^yDlGeCj_@wTln@`AlZyEhTtDdTkAzQ~Eh\\cAdKpArO_Al^wChD`BlJdIrWfRza@`L|t@|M|OzMrGbTiDjJjWlH_DdDkLc@aNjBuFtDhDnHaDlGv@|FfGdCxJ?jO}Ej[cEvv@jRrcBIpKvBvCbVrwBe@~DkD_BcRvJsNpPoJnRuGJ@rQiD`JvC|Rq@bNmTnp@iAdRzJlFnExOzh@`PnUj[|WdU`LdA|KoHrBbLlTbc@lj@dy@z[vCnf@_QfY|BxD~QF|N~AvGtGbIbO|FzKd_@eAjc@}IxSkLbM}Drc@`Eh[jF`Kc@tQlNhNNhPtBzHzLiEl\\jGxCkK`o@yPvD~Ag@`IbNlZ~GeGlI_@fK|FvLwKhI`Gli@jCfIba@zLfIdCdFoWtRRzGiClQvFtQwC~Ip@zWyOtRuC~Io@bPmKx]{DhX|BjMaKbf@eDlCqNfB{PfWeItVVvM|FjSKjNhF`WhIrI|SlChO{[lFlAlMcGtW`IjA|\\~D~KdI|A|FyJvJf@dFuDtEtJxRjKtHkHdOnCdB~DyAsDeOkDcIbHkRgK{FqKgErEyJg@oFxJgIcBoEiLsA_]cVwHoL`G}Hc@kNnZqTkDyI}J}E_VVwL_G}Si@yJ~HaWrRkYfDmCxMuAbKcf@aCeNxDkWjKq]h@}OtCiJdPgRcAgUbDeNsFaPxBg[jTiMpLmZhNqFrG`GdC[nK_FzFuMpTaHtFwJfLeZp@}DgAiMrD{O_EyULoO|@aF~F_JwIwNv@mK_AqTyB}LwF_Ef@_MeHkJwNaIwIuReHkXeViNOsRib@{MeFcLkRwPFvPwHzDuDoC_FnAaJ`OgWfCqQ`PaCbPoH`D_OeYwJhFkOUmVmHmAaN~Gu{@|R{g@xGYfKoRhDrVr`@xSpBcMrHoMeA{OzGgVeAeYpBsK_AsF{I_H_Uc\\kp@yg@af@zx@iKhLeMpE_GzJ_JAoSqJzA}HaDaOfQyP|EcWvEaBzCwJfRfFdDrFjCuCcBw\\gF_E{GsP`Jq\\qHaPeF{a@P}`@cEeM{K}OLoM{E}WoHuIyA_\\}DsP}GeJu[aOgg@yQa[mE}@aKcKuElQyd@_g@mg@cq@g_A{GkAoF`CwM_^sMm@eKfKqChPp@fVwDdYsGhIsOx@uBvG~@vN}DnMaFzBmDoDyF{RoSvDqMoGoNiPeLeu@wQu`@{CqP_E}GoAoI`DuDp@c^qAgPbAyJgFk]pAcRqDkN~EeXwAcWlW_y@dAeXzDgHjEe^Rqi@dOxHhKxB~c@sdA",
          "resource_state": 2
        },
        "trainer": false,
        "commute": false,
        "manual": false,
        "private": false,
        "visibility": "everyone",
        "flagged": false,
        "gear_id": "b3865563",
        "from_accepted_tag": false,
        "upload_id_str": "4954712482",
        "average_speed": 6.378,
        "max_speed": 16.4,
        "device_watts": false,
        "has_heartrate": false,
        "heartrate_opt_out": false,
        "display_hide_heartrate_option": false,
        "elev_high": 151.3,
        "elev_low": 4.3,
        "pr_count": 10,
        "total_photo_count": 1,
        "has_kudoed": false
      }
    }
  end
end
