defmodule Strava.RouteTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    HTTPoison.start
  end

  test "retrieve route" do
    use_cassette "route/retrieve#1119914" do
      route = Strava.Route.retrieve(1119914)

      assert route != nil
      assert route.name == "Rondo Babka course"
      assert route.description == "Faktyczny punkt od którego zaczyna się ściganie jest nieco dalej niż zaznaczony start na mapie..."
      assert route.timestamp == ~N[2014-11-01 19:09:20]
      assert route.athlete.id == 784663
      assert route.map.id == "r1119914"
      assert route.map.polyline == "oyu~Hemr~BeBvFQOw@@qFf@cOhJmDbC}tAjcAoWvRgExCqH`GaEnDgDbD_@X}@d@oBt@[DQAUKILE@MKCWiAa@mGgC}@e@_@_@[cAoAeJe@w@qB}AgDyBkCyAeAW_AE_APcC|AsB`BuWzMsEnB{OtHqAx@m@r@mWji@cFrKsQ~^oGbNm@jAaA~AaBlBuAv@aKzEaFtBmAp@e@`@}AtB_@^[La@HqABaSjAg@XeN|QgRmn@gRan@Ia@GkApAkcB`BqmBT{S`@oj@KuHE?MKGUmKfIcCfBsEnBiCb@}Ge@iCf@ca@zKsU`E}K`BgPG_D@gBKyBo@}AeAwAuAmBcC}AaDaPyWkC{DaCsByB_AyA]{BM_NSwCKc[s@{H@eAJmAZiAf@aAr@uA~Au@nAyA`DeOz\\k@fAk@p@aAz@y@b@qAZQMOBGLEVmBhAu`@pRwBjAwBjBcDdEsYj`@cx@n~@eVpYsjBfxB}DhEsA`A{Bb@wBC{jAFuuA`Ac@Zc@|@{AnEoA|FeAhXm@|Iw@rDoAxCsBbCyo@dnA_]bp@qCbFaFtJW`@Lz@HvA?jAYbJYbMwClhA{CpgA{DbV_A|GOx@S|@cAvCsExQWvAkA~DG`@?n@J~@`@lBZt@~UvhArMhm@dAlFvFrVtE~Mp@v@`FbFf@j@\\f@JnA\\hHpEncA~Cpt@r@dH|BtMzRv`AlBpKxChWp@xIj@lF|DlSzGn\\zFvZxFfXvGr]~Knq@jLjbAxIdt@^fH`Bdr@bDsKz@kAtFyC~MwPzh@ePpZan@nBgDlAqAdCoApAUtFa@lJkApNa@z@B~JfB`Q`Dz@\\pDzBpAb@pHSfCWfGiBrFoBvQmIjGK|ERnMpCp@gi@QBPCzK{CxHhBnJDdMjCfd@Nnl@kUvCeMUs_@G_g@oBkYfY}z@`AcNvGmM~KaFrJ}Rp@eBZa@d@Wh@O~D^nAGjAa@pAYjBEtHh@IVjA}CrA}BrAiBrLmRzKeOnC{DhL_UTk@q@RrAc@jDqAzDj\\bBpMnEv^`@xELbDJrKJ~BXlBd@~Ah@hAj@v@v@n@|@`@fAL~@GzH_BvAOr@Bx@TbBfA~LpJd]~VdCrBx^fXt@v@d@bAVdAl@~EnSnJf@\\Zb@X~@pKbh@nDlP`A|NzCeC`CeAzA[p@G`G[n@?HFJAl@i@vJ}@j@Br@RzLzE`AXbANp@Av@OhPoFhCw@j@Ex@Jn@`@|AzAtEzEpAyE|FcS|@cCv@aBrBwDhAwAlAqAf`@m]|A}AxAgBdAaBbAkBtAkDf@_BfAkElA}H`@eFNqDDwDEeEUgEWqDuH{y@EsAk@yHQsDAcBBsEP}Eb@}E~W{`CfEm^jgAefJvZslCbb@mqDxImv@lKo_Az@cHd@wC`@mBr@sCbUev@"
      assert route.map.summary_polyline == "oyu~Hemr~BeBvF{HXcOhJ}pCvtBcE|@gLsFqDaOkPoIo{@lc@s~@blBi`@nVuVxAmOvRaf@}`B~E_|GaW|NgLA_iAfVgUEwKwEyZ{f@{FsDadAuAwGjGwTve@qs@j_@w^pf@ocEtzEijDdCoEjOkDzh@i`Bb|CoIfqDkGz`@wKxc@zp@f}CtE~MxInJnM`nCfZ~{AvFpi@fs@`wDdWpwB`Cl{@~E_NtFyC~MwPzh@ePpZan@bIiIbf@aD`g@fMxLk@ra@gPx\\xC^ci@lL_Dnb@zFfd@Nnl@kUvCeM]sgAoBkYfY}z@`AcNvGmM~KaF`MeWt[Ore@ut@~LkVq@R~FuBnNtjAfAp[hBvGhFvC`Q}AhrAtaA`D`LvTlKvRt|@`A|N|GkEzZaDrUzGvW}H|KdJxP{f@vj@}h@fGyMtCiOp@uWgLwwAv@sVr~Dsh]~X_cA"
    end
  end

  test "list routes" do
    use_cassette "route/list#3920819" do
      routes = Strava.Route.list_routes(3920819)

      assert routes != nil
      assert length(routes) == 10

      first_route = hd(routes)
      assert first_route.id == 2993947
      assert first_route.name == "Ciepło trochę. Strava zabrała 30km :)"
    end
  end
end
