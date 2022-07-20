var result = await cluster.QueryAsync<dynamic>(
    "select count(*) from `travel-sample`.inventory.airport where country = ?",
    options =>
        options.Parameter("France")
        .AdHoc(false);
);