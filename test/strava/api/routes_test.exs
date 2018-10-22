defmodule Strava.RoutesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  import Strava.AssertionHelpers

  describe "routes" do
    test "#get_route_by_id" do
      use_cassette "routes/get_route_by_id", match_requests_on: [:query] do
        client = Strava.Client.new()

        {:ok,
         %Strava.Route{
           name: name,
           description: description,
           timestamp: timestamp,
           athlete: %Strava.SummaryAthlete{} = athlete,
           map: %Strava.PolylineMap{} = map
         }} = Strava.Routes.get_route_by_id(client, 1_119_914)

        assert name == "Rondo Babka course"

        assert description ==
                 "Faktyczny punkt od którego zaczyna się ściganie jest nieco dalej niż zaznaczony start na mapie..."

        assert timestamp == 1_414_868_960
        assert athlete.id == 784_663
        assert map.id == "r1119914"

        assert map.polyline ==
                 "oyu~Hemr~BeBvFQOw@@qFf@cOhJmDbC}tAjcAoWvRgExCqH`GaEnDgDbD_@X}@d@oBt@[DQAUKILE@MKCWiAa@mGgC}@e@_@_@[cAoAeJe@w@qB}AgDyBkCyAeAW_AE_APcC|AsB`BuWzMsEnB{OtHqAx@m@r@mWji@cFrKsQ~^oGbNm@jAaA~AaBlBuAv@aKzEaFtBmAp@e@`@}AtB_@^[La@HqABaSjAg@XeN|QgRmn@gRan@Ia@GkApAkcB`BqmBT{S`@oj@KuHE?MKGUmKfIcCfBsEnBiCb@}Ge@iCf@ca@zKsU`E}K`BgPG_D@gBKyBo@}AeAwAuAmBcC}AaDaPyWkC{DaCsByB_AyA]{BM_NSwCKc[s@{H@eAJmAZiAf@aAr@uA~Au@nAyA`DeOz\\k@fAk@p@aAz@y@b@qAZQMOBGLEVmBhAu`@pRwBjAwBjBcDdEsYj`@cx@n~@eVpYsjBfxB}DhEsA`A{Bb@wBC{jAFuuA`Ac@Zc@|@{AnEoA|FeAhXm@|Iw@rDoAxCsBbCyo@dnA_]bp@qCbFaFtJW`@Lz@HvA?jAYbJYbMwClhA{CpgA{DbV_A|GOx@S|@cAvCsExQWvAkA~DG`@?n@J~@`@lBZt@~UvhArMhm@dAlFvFrVtE~Mp@v@`FbFf@j@\\f@JnA\\hHpEncA~Cpt@r@dH|BtMzRv`AlBpKxChWp@xIj@lF|DlSzGn\\zFvZxFfXvGr]~Knq@jLjbAxIdt@^fH`Bdr@bDsKz@kAtFyC~MwPzh@ePpZan@nBgDlAqAdCoApAUtFa@lJkApNa@z@B~JfB`Q`Dz@\\pDzBpAb@pHSfCWfGiBrFoBvQmIjGK|ERnMpCp@gi@QBPCzK{CxHhBnJDdMjCfd@Nnl@kUvCeMUs_@G_g@oBkYfY}z@`AcNvGmM~KaFrJ}Rp@eBZa@d@Wh@O~D^nAGjAa@pAYjBEtHh@IVjA}CrA}BrAiBrLmRzKeOnC{DhL_UTk@q@RrAc@jDqAzDj\\bBpMnEv^`@xELbDJrKJ~BXlBd@~Ah@hAj@v@v@n@|@`@fAL~@GzH_BvAOr@Bx@TbBfA~LpJd]~VdCrBx^fXt@v@d@bAVdAl@~EnSnJf@\\Zb@X~@pKbh@nDlP`A|NzCeC`CeAzA[p@G`G[n@?HFJAl@i@vJ}@j@Br@RzLzE`AXbANp@Av@OhPoFhCw@j@Ex@Jn@`@|AzAtEzEpAyE|FcS|@cCv@aBrBwDhAwAlAqAf`@m]|A}AxAgBdAaBbAkBtAkDf@_BfAkElA}H`@eFNqDDwDEeEUgEWqDuH{y@EsAk@yHQsDAcBBsEP}Eb@}E~W{`CfEm^jgAefJvZslCbb@mqDxImv@lKo_Az@cHd@wC`@mBr@sCbUev@"

        assert map.summary_polyline ==
                 "oyu~Hemr~BeBvF{HXcOhJ}pCvtBcE|@gLsFqDaOkPoIo{@lc@s~@blBi`@nVuVxAmOvRaf@}`B~E_|GaW|NgLA_iAfVgUEwKwEyZ{f@{FsDadAuAwGjGwTve@qs@j_@w^pf@ocEtzEijDdCoEjOkDzh@i`Bb|CoIfqDkGz`@wKxc@zp@f}CtE~MxInJnM`nCfZ~{AvFpi@fs@`wDdWpwB`Cl{@~E_NtFyC~MwPzh@ePpZan@bIiIbf@aD`g@fMxLk@ra@gPx\\xC^ci@lL_Dnb@zFfd@Nnl@kUvCeM]sgAoBkYfY}z@`AcNvGmM~KaF`MeWt[Ore@ut@~LkVq@R~FuBnNtjAfAp[hBvGhFvC`Q}AhrAtaA`D`LvTlKvRt|@`A|N|GkEzZaDrUzGvW}H|KdJxP{f@vj@}h@fGyMtCiOp@uWgLwwAv@sVr~Dsh]~X_cA"
      end
    end

    test "#get_routes_by_athlete_id" do
      use_cassette "routes/get_routes_by_athlete_id", match_requests_on: [:query] do
        client = Strava.Client.new()
        athlete_id = authenticated_athlete_id()

        {:ok, routes} = Strava.Routes.get_routes_by_athlete_id(client, athlete_id)

        for route <- routes do
          assert %Strava.Route{map: %Strava.PolylineMap{}} = route

          assert is_number(route.timestamp)
          assert is_number(route.athlete.id)
          assert_present(route.map.id)
          assert_present(route.map.summary_polyline)
        end
      end
    end
  end

  defp authenticated_athlete_id do
    Application.get_env(:strava, :test, [])[:athlete_id] || System.get_env("STRAVA_ATHLETE_ID")
  end
end
