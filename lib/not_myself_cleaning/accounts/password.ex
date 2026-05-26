defmodule NotMyselfCleaning.Accounts.Password do
  @algorithm "pbkdf2_sha256"
  @iterations 210_000
  @salt_bytes 16
  @hash_bytes 32

  def hash(password) when is_binary(password) do
    salt = :crypto.strong_rand_bytes(@salt_bytes)
    encoded_hash = derive(password, salt, @iterations) |> Base.encode64()
    encoded_salt = Base.encode64(salt)

    Enum.join([@algorithm, @iterations, encoded_salt, encoded_hash], "$")
  end

  def verify(password, encoded) when is_binary(password) and is_binary(encoded) do
    with [@algorithm, iterations, encoded_salt, encoded_hash] <- String.split(encoded, "$"),
         {iterations, ""} <- Integer.parse(iterations),
         {:ok, salt} <- Base.decode64(encoded_salt),
         {:ok, hash} <- Base.decode64(encoded_hash) do
      password
      |> derive(salt, iterations)
      |> secure_equal?(hash)
    else
      _ -> false
    end
  end

  def verify(_, _), do: false

  def no_user_verify do
    verify("invalid", hash("invalid"))
    :ok
  end

  defp derive(password, salt, iterations) do
    :crypto.pbkdf2_hmac(:sha256, password, salt, iterations, @hash_bytes)
  end

  defp secure_equal?(left, right) when byte_size(left) == byte_size(right) do
    Plug.Crypto.secure_compare(left, right)
  end

  defp secure_equal?(_, _), do: false
end
