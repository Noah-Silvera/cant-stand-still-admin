rider = Rider.create!(
  user_id: 1,
  refresh_token: "fake_refresh_token",
  access_token: "fake_access_token",
  athlete_json: {
    "firstname": "Noah",
    "lastname": "Silvera",
    "profile": "https://placekitten.com/400/400",
    "profile_medium": "https://placekitten.com/200/200"
  }
)

Rider.create!(
  user_id: 2,
  refresh_token: "fake_refresh_token",
  access_token: "fake_access_token",
  athlete_json: {
    "firstname": "Saskia",
    "lastname": "Kowalik",
    "profile": "https://placekitten.com/400/400",
    "profile_medium": "https://placekitten.com/200/200"
  }
)

rides = [
  Ride.create!(
    rider: rider,
    start_date: 2.hours.ago,
    activity_json: {
      "resource_state": 2,
      "athlete": {
        "id": 22140740,
        "resource_state": 1
      },
      "name": "Big loop bike camping pt1",
      "distance": 80344.2,
      "moving_time": 14489,
      "elapsed_time": 21390,
      "total_elevation_gain": 635.0,
      "type": "Ride",
      "workout_type": 10,
      "id": 1754190446,
      "external_id": "F9F79F9B-FEB0-4A61-9F6E-CB46FA0E329F",
      "upload_id": 1883343762,
      "start_date": "2018-08-03T20:23:35Z",
      "start_date_local": "2018-08-03T13:23:35Z",
      "timezone": "(GMT-08:00) America/Vancouver",
      "utc_offset": -25200.0,
      "start_latlng": [
        48.46,
        -123.32
      ],
      "end_latlng": [
        48.77,
        -123.87
      ],
      "location_city": nil,
      "location_state": nil,
      "location_country": nil,
      "start_latitude": 48.46,
      "start_longitude": -123.32,
      "achievement_count": 17,
      "kudos_count": 8,
      "comment_count": 0,
      "athlete_count": 1,
      "photo_count": 0,
      "map": {
        "id": "a1754190446",
        "summary_polyline": "mtxfHrcuoVmZyFM`_CeQv[yBdYdJ~jAf[`Rr_@dl@bFtRvRlSv@tPkOttAwRbBeMvKqGrR_JrIorAl`Agj@xT_UzUooAHet@g]wLvIaO|^kO`Jav@nxAucAbBsn@t_Aa_@cKsMjAid@vw@oc@ra@kJcB_Ca[cTo]U|x@{L~SoG`CaJ}EtEfi@iDfX}z@nxAy_ApfA}{ApyAiR`e@ytA`u@gSbDmr@npA_WnZcG|VuZb`@yL|Aa@|Mc\\hD{l@uHi@_m@id@xGil@uOo`@No`@t\\s_@dbAcS|MyJ~VoVvKwU|U{]mD_Au`@qFcY`BwUoEc@l@iEFxIvCOkA_M{VeFaR|RuHdg@tAtv@c`@nt@_WzC_@|z@dE~MaExQr@rcJnBpRkCxYrHxYgE|X}@rm@ik@zoAoKUkQbJqb@wP{HsKmc@gGe^rd@kThN{J}DoJxg@mZlg@yEjFkCoDgB~FlCzAkEq@xBgBNpDiAkDzB_FeEgPgPqNkO~f@qa@rR}FpLnHd_@`[tq@mAzj@~RvpAaEji@tJvSzRj~@Hrk@xT~}AJrOhIxNhDt_@`Fj@zNdXbEp^lDbEvFprAdF~SaClZsPtl@f@tx@yBrSuOg@oPpXqPnIvClaAhAnE`GuC",
        "resource_state": 2
      }
    },
    activity_id: 1
  ),
  Ride.create!(
    rider: rider,
    start_date: 1.hours.ago,
    activity_json:   {
      "resource_state": 2,
      "athlete": {
        "id": 22140740,
        "resource_state": 1
      },
      "name": "Checking out that new tunnel from cowichan to renfrew",
      "distance": 81132.4,
      "moving_time": 13833,
      "elapsed_time": 35097,
      "total_elevation_gain": 1444.6,
      "type": "Ride",
      "workout_type": 10,
      "id": 1754190452,
      "external_id": "E9128D9B-E00A-4D59-AB62-7F0450949F53",
      "upload_id": 1883343818,
      "start_date": "2018-08-04T17:16:12Z",
      "start_date_local": "2018-08-04T10:16:12Z",
      "timezone": "(GMT-08:00) America/Vancouver",
      "utc_offset": -25200.0,
      "start_latlng": [
        48.78,
        -123.89
      ],
      "end_latlng": [
        48.42,
        -124.03
      ],
      "location_city": nil,
      "location_state": nil,
      "location_country": nil,
      "start_latitude": 48.78,
      "start_longitude": -123.89,
      "achievement_count": 0,
      "kudos_count": 9,
      "comment_count": 0,
      "athlete_count": 1,
      "photo_count": 0,
      "map": {
        "id": "a1754190452",
        "summary_polyline": "wdvhHfscsVaW~a@_SsOkHgTaKyIkIbEsH|~@sK|c@qSha@{Ib}@cMta@vI`f@_RphAoAfa@yE\\zCpH}@tOyJjQ}T|}AmOvUi@bKqLbNmFfWcEjo@iRvT{[xrA_LrTfAfUwIr`@u@v[yIzOgPxq@lPfgAbNfg@ntd@jwe@nPiEjNmN|Msq@fKyCtAgM`IcLhIu@xEeKpIcC~DaWnQma@hb@`D~DlXJn_@dq@~Dhd@bwAwEvh@zAvYhJj]wI`l@fGbg@?|c@{Vz`@i@xMjX~t@lGz`DvPlu@oBvm@bId`@yFl[zGd_@_@v_@|M|{AfLfp@dI|kAnJx@hm@de@nPnFnQoI|[UYgDtB|S_@iNpPwL`IfJg`@cqBtHqWsG_f@`Equ@`No{@lLbLpWzCzx@hw@bf@tAp]wGnHuZnSwYvTcq@hTmbAt@eRlK}]BgQtL}T~O_q@oAof@xEul@qHad@tEmg@xUoMhY~LnIoDxNef@tKaIwB_XtD}CpEiVqEug@~KpJ~SsAgHe_@~Ea]~Dti@hOzXxf@oAjD_`@tJkY`Eik@rN_s@vK}MrFwS|Cge@nLqZ`Lyo@jQgKxJm[tLixC`Ksm@Z}[`Roh@dVysArKmQzGqZvQkgArVodCp]g{@b@}~CzUsKlMq`@xTiUnJw\\vAmc@tKnSzOwA]aX`Oqv@uAkJuDiIfAxCiKrDqPmDmFsLpC_VpVs{@cC`I",
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
      "upload_id_str": "1883343818",
      "average_speed": 5.865,
      "max_speed": 21.5,
      "device_watts": false,
      "has_heartrate": false,
      "heartrate_opt_out": false,
      "display_hide_heartrate_option": false,
      "elev_high": 288.2,
      "elev_low": -2.6,
      "pr_count": 0,
      "total_photo_count": 7,
      "has_kudoed": false
    },
    activity_id: 2
  ),
  Ride.create!(
    rider: rider,
    start_date: Time.zone.now,
    activity_json: {
      "resource_state": 2,
      "athlete": {
        "id": 22140740,
        "resource_state": 1
      },
      "name": "Biking mead and biking",
      "distance": 78681.9,
      "moving_time": 15458,
      "elapsed_time": 85838,
      "total_elevation_gain": 1104.1,
      "type": "Ride",
      "workout_type": 10,
      "id": 1754190644,
      "external_id": "A6F9752F-A4A1-44CB-9E1C-FFD640EB0641",
      "upload_id": 1883343909,
      "start_date": "2018-08-05T17:27:28Z",
      "start_date_local": "2018-08-05T10:27:28Z",
      "timezone": "(GMT-08:00) America/Vancouver",
      "utc_offset": -25200.0,
      "start_latlng": [
        48.42,
        -124.03
      ],
      "end_latlng": [
        48.46,
        -123.35
      ],
      "location_city": nil,
      "location_state": nil,
      "location_country": nil,
      "start_latitude": 48.42,
      "start_longitude": -124.03,
      "achievement_count": 9,
      "kudos_count": 12,
      "comment_count": 0,
      "athlete_count": 1,
      "photo_count": 0,
      "map": {
        "id": "a1754190644",
        "summary_polyline": "cqpfHpt_tVjZaaAjc@em@tMsd@IoQfKqu@zSy[lj@ya@pPoz@sA_iAuHai@g@ob@bUseA{Duy@bCo^nR_d@`Aee@vHmn@hGoFcGrBuEk`@zE_\\sAyFkR}DuE{HuP|@aE{E|F_}@~}@ov@rb@iDZcFoLyP\\eNtK{L`Mut@`VeRjIw}@yDuI_AxC^oIl@`DyBJfC?[cEr@tD}B}E~BnAaAnESyEyAzCvB_D`@zHcBaRnDbThF_E~MiYfXqSrn@_u@qOoq@gDik@iJwVuA}TqOe`@vDeq@mZui@oNg}AeAusAlg@a~@_@ie@cKqZs`@{]}P{D}IeJcQ{cAuQqg@{Ti\\n@y|AyLkXaGoc@yA__A}Ty~@|C_OhW_DzXia@s@wMyT_\\[q\\fDwNzDvFni@zNpT}RrIpDdPuPjDkY~BS~Ksb@fHmIrR}qAuEej@hFg]rZsM~GgPfCs\\jUi]~Dym@{Di_@vHw_AcAoU_FqGe[aEwK~ComAoi@ah@h[}j@tFo\\vOyT{A{VgK_Rgp@}gDsiAcVqU_I}_@jAeBiQu}AcEiKh@eJcRocBnL}rAmAcWwLmLeUr@u@lUiInOqMqWkh@mJoIgLiJuo@mRya@cL_c@bDgDj@c_@Gu[wFu^`B{PqD}M|EqYmAiVlUms@tBk]nEgJ|D{^Agc@zNgfAkBcNeQcRlMo_@iDac@jDkAmDox@jBwF",
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
      "upload_id_str": "1883343909",
      "average_speed": 5.09,
      "max_speed": 20.8,
      "device_watts": false,
      "has_heartrate": false,
      "heartrate_opt_out": false,
      "display_hide_heartrate_option": false,
      "elev_high": 132.2,
      "elev_low": -10.5,
      "pr_count": 4,
      "total_photo_count": 2,
      "has_kudoed": false
    },
    activity_id: 3
  )
]

Trip.create!(
  name: "Past Bike Trip",
  rider: rider,
  start_date: 3.hours.ago,
  end_date: 1.day.from_now
)
Trip.create!(
  name: "Current Bike Trip",
  rider: rider,
  start_date: 1.hours.ago,
  end_date: nil
)
