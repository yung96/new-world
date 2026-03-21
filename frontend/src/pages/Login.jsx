import { useState } from "react";
import { useNavigate, useLocation } from "react-router-dom";
import { motion } from "framer-motion";
import { Phone, ArrowRight, MapPin } from "lucide-react";
import { useApp } from "../context/AppContext";

export default function Login() {
  const [phone, setPhone] = useState("");
  const [code, setCode] = useState("");
  const [step, setStep] = useState("phone");
  const { login } = useApp();
  const navigate = useNavigate();
  const location = useLocation();
  const from = location.state?.from || "/feed";

  const handleSendCode = (e) => {
    e.preventDefault();
    if (phone.length >= 10) {
      setStep("code");
    }
  };

  const handleVerify = (e) => {
    e.preventDefault();
    if (code.length >= 4) {
      login(phone);
      navigate(from, { replace: true });
    }
  };

  return (
    <div className="min-h-dvh bg-white flex flex-col">
      {/* Header */}
      <div className="px-6 pt-[env(safe-area-inset-top,16px)] pb-4">
        <button
          onClick={() => navigate(-1)}
          className="text-sm text-gray-medium mt-4"
        >
          ← Назад
        </button>
      </div>

      <div className="flex-1 flex flex-col items-center justify-center px-8 pb-16">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="w-full max-w-sm"
        >
          {/* Logo */}
          <div className="flex items-center gap-2 mb-2">
            <div className="w-10 h-10 rounded-xl instagram-gradient flex items-center justify-center">
              <MapPin size={20} className="text-white" />
            </div>
            <span className="text-xl font-bold bg-gradient-to-r from-primary to-secondary bg-clip-text text-transparent">
              Краевед
            </span>
          </div>

          <h1 className="text-2xl font-bold text-dark mt-6 mb-1">
            {step === "phone" ? "Войти в аккаунт" : "Введите код"}
          </h1>
          <p className="text-sm text-gray-medium mb-8">
            {step === "phone"
              ? "Чтобы оставлять отзывы, сохранять места и получать достижения"
              : `Мы отправили SMS на ${phone}`}
          </p>

          {step === "phone" ? (
            <form onSubmit={handleSendCode} className="space-y-4">
              <div className="relative">
                <Phone size={18} className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-300" />
                <input
                  type="tel"
                  placeholder="+7 (___) ___-__-__"
                  value={phone}
                  onChange={(e) => setPhone(e.target.value)}
                  className="w-full pl-12 pr-4 py-3.5 bg-gray-light border border-gray-200 rounded-xl text-base focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition-all"
                  autoFocus
                />
              </div>
              <button
                type="submit"
                disabled={phone.length < 10}
                className={`w-full py-3.5 rounded-xl text-base font-semibold flex items-center justify-center gap-2 transition-all ${
                  phone.length >= 10
                    ? "bg-primary text-white shadow-lg shadow-primary/20"
                    : "bg-gray-100 text-gray-300 cursor-not-allowed"
                }`}
              >
                Получить код
                <ArrowRight size={18} />
              </button>
            </form>
          ) : (
            <form onSubmit={handleVerify} className="space-y-4">
              <div className="flex gap-3 justify-center">
                {[0, 1, 2, 3].map((i) => (
                  <input
                    key={i}
                    type="text"
                    inputMode="numeric"
                    maxLength={1}
                    value={code[i] || ""}
                    onChange={(e) => {
                      const val = e.target.value.replace(/\D/, "");
                      const newCode = code.split("");
                      newCode[i] = val;
                      setCode(newCode.join(""));
                      if (val && i < 3) {
                        e.target.nextElementSibling?.focus();
                      }
                    }}
                    onKeyDown={(e) => {
                      if (e.key === "Backspace" && !code[i] && i > 0) {
                        e.target.previousElementSibling?.focus();
                      }
                    }}
                    className="w-14 h-14 text-center text-2xl font-bold bg-gray-light border border-gray-200 rounded-xl focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition-all"
                    autoFocus={i === 0}
                  />
                ))}
              </div>
              <button
                type="submit"
                disabled={code.length < 4}
                className={`w-full py-3.5 rounded-xl text-base font-semibold flex items-center justify-center gap-2 transition-all ${
                  code.length >= 4
                    ? "bg-primary text-white shadow-lg shadow-primary/20"
                    : "bg-gray-100 text-gray-300 cursor-not-allowed"
                }`}
              >
                Войти
                <ArrowRight size={18} />
              </button>
              <button
                type="button"
                onClick={() => setStep("phone")}
                className="w-full text-sm text-gray-medium text-center"
              >
                Изменить номер
              </button>
            </form>
          )}

          {/* Divider */}
          <div className="flex items-center gap-3 mt-8 mb-4">
            <div className="flex-1 h-px bg-gray-200" />
            <span className="text-xs text-gray-300">или</span>
            <div className="flex-1 h-px bg-gray-200" />
          </div>

          {/* Quick mock login */}
          <button
            onClick={() => {
              login("+7 (999) 123-45-67");
              navigate(from, { replace: true });
            }}
            className="w-full py-3 border-2 border-gray-200 rounded-xl text-sm font-medium text-gray-500 hover:border-primary hover:text-primary transition-all"
          >
            Быстрый вход (демо)
          </button>
        </motion.div>
      </div>
    </div>
  );
}
